# Managing entities

This guide explains how entities are managed.


## Creating Entities

Entities can be created by two different methods. They can either be included in the initial configuration of a scene or be created dynamically during
execution of a scene. In the first case the engine creates the entities before initializing the scene. In the latter the developer must take care of the
creation.

Here you can see the scene view of a scene in SpellEd which includes the two entities *camera* and *entity1*. The entity *entity1* is currently selected and
its component configuration is shown in the inspector view on the right.

{@img creatingEntity1.png}


The following code example will create an entity with three components. Coincidentally the three components used in the example allow the entity to be
rendered by the default rendering system *spell.system.render*. You can try the example code by pasting it into the *init* method of a system. Just create a
system template, add the system to your current scene and reload the scene.

<pre><code>
define(
	'example/test',
	[
		'spell/functions'
	],
	function(
		_
	) {
		'use strict'


		var test = function( spell ) {

		}

		test.prototype = {
			init: function( spell ) {
				spell.entityManager.createEntity(
					{
						config : {
							"spell.component.visualObject": {
								// if no attribute configuration is provided the component's default values will be used
							},
							"spell.component.2d.graphics.appearance": {
								// if no attribute configuration is provided the component's default values will be used
							},
							"spell.component.2d.transform": {
								"translation" : [ 50, 50 ]
							}
						}
					}
				)
			},
			destroy: function( spell ) {},
			activate: function( spell ) {},
			deactivate: function( spell ) {},
			process: function( spell, timeInMs, deltaTimeInMs ) {}
		}

		return test
	}
)
</code></pre>

As you can see an entity has been created at the position [ 50, 50 ]. Please also note that the origin of the entity is located at the entity's center.

{@img creatingEntity2.png}


## Updating Components

Extend the code from the previous example so that it matches the following example.

<pre><code>
...
init: function( spell ) {
	var entityId = spell.entityManager.createEntity(
		{
			config : {
				"spell.component.visualObject": {
					// if no attribute configuration is provided the component's default values will be used
				},
				"spell.component.2d.transform": {
					"translation" : [ 50, 50 ]
				},
				"spell.component.2d.graphics.appearance": {
					// if no attribute configuration is provided the component's default values will be used
				}
			}
		}
	)

	// teleport the entitiy to position [ -50, 50 ]
	var teleportEntity = function() {
		spell.entityManager.updateComponentAttribute(
			entityId,
			"spell.component.2d.transform",
			"translation",
			[ -50, 50 ]
		)
	}

	// whenever a keyDown input event occurs teleport the entity
	spell.inputManager.addListener( 'keyDown', teleportEntity )
},
...
</code></pre>

As you can see any key press will now teleport the entity to position [ 50, 50 ]. The call to the updateComponentAttribute method references the previously
created entity by its entity id.

{@img creatingEntity3.png}


Modify your system so that it matches the following code example.

<pre><code>
define(
	'example/test',
	[
		'spell/math/random/XorShift32',
		'spell/functions'
	],
	function(
		XorShift32,
		_
	) {
		'use strict'


		var test = function( spell ) {

		}

		test.prototype = {
			init: function( spell ) {
				var prng = new XorShift32( 12341234 )

				var createEntity = function() {
					var scaleFactor = prng.nextBetween( 0.25, 1 )

					spell.entityManager.createEntity(
						{
							config : {
								"spell.component.visualObject": {},
								"spell.component.2d.graphics.appearance": {},
								"spell.component.2d.transform": {
									"rotation" : prng.nextBetween( -1, 1 ),
									"scale" : [ scaleFactor, scaleFactor ],
									"translation" : [
										prng.nextBetween( -100, 100 ),
										prng.nextBetween( -100, 100 )
									]
								}
							}
						}
					)
				}

				// whenever a keyDown input event occurs create another entity
				spell.inputManager.addListener( 'keyDown', createEntity )
			},
			destroy: function( spell ) {},
			activate: function( spell ) {},
			deactivate: function( spell ) {},
			process: function( spell, timeInMs, deltaTimeInMs ) {}
		}

		return test
	}
)
</code></pre>


Now a new entity with a randomized transformation will be created everytime a key is pressed.

{@img creatingEntity4.png}


## Removing Entities

Entities can be removed by calling the entity manager's removeEntity method with the entity id of the entity you want to remove as first argument.

<pre><code>
...
init: function( spell ) {
	var prng      = new XorShift32( 12341234 ),
		entityIds = []

	// creates another entity and stores its id in the entityIds array
	var createEntity = function() {
		var scaleFactor = prng.nextBetween( 0.25, 1 )

		var entityId = spell.entityManager.createEntity(
			{
				config : {
					"spell.component.visualObject": {},
					"spell.component.2d.graphics.appearance": {},
					"spell.component.2d.transform": {
						"rotation" : prng.nextBetween( -1, 1 ),
						"scale" : [ scaleFactor, scaleFactor ],
						"translation" : [
							prng.nextBetween( -100, 100 ),
							prng.nextBetween( -100, 100 )
						]
					}
				}
			}
		)

		entityIds.push( entityId )
	}

	// pops the last entity id from the entityIds array and removes the entity
	var removeEntity = function() {
		spell.entityManager.removeEntity( entityIds.pop() )
	}

	// whenever a keyDown input event occurs check if its either the "+" or "-" key and act accordingly
	spell.inputManager.addListener(
		'keyDown',
		function( event ) {
			var keyCode = event.keyCode

			if( keyCode == spell.inputManager.KEY.ADD ) {
				createEntity()

			} else if( keyCode == spell.inputManager.KEY.SUBTRACT ) {
				removeEntity()
			}
		}
	)
},
...
</code></pre>

Now you can add and remove entites by pressing the "+" and "-" keys.


## Entity Templates

Entity templates are a powerful tool which allows the separation of code from the concrete entity configuration. Specific entity configurations can be stored
in entity templates and used for creating entities based on the template. As long as the library id of the entity template stays the same the entity template
can be edited and code referencing it will create entities based on the updated entity template configuration.

### Creating Entity Templates

To create an entity template execute the *Create Template from Entity* function on an existing entity which is included in a scene or use the *Create*
function in the library.

{@img creatingEntityTemplate1.png}


Choose a valid library id for the entity template and finish the creation process by clicking *Create*.

{@img creatingEntityTemplate2.png}


As you can see the icon of the entity you created the template from changed to a linked entity icon. This means that it the entity is based on an entity
template.


### Creating Entities based on Templates

Now create a new entity based on the entity template you just created.

{@img creatingEntityTemplate3.png}


The transformation of the new entity *entity2* was changed slightly in order to make it stand out against *entity1*. Without this change both entities would
occupy the exact same location and space. After all they both reference the same entity template. It is easy to get confused when entities overlap other
entities so keep an eye on the transformation component to prevent this.

{@img creatingEntityTemplate4.png}


In case you were wondering what happened to the differing entity configuration of *entity2*. The entity instance configuration of *entity2* has a higher
priority than the configuration provided through the entity template it references. This makes it possible to flexibly create entities based on entity
templates and still make any of the "clones" unique. Imagine a group of enemies which only differ in appearance. You could create an enemy entity template
and overwrite just the appearance and transform component on every entity instantiation.


### Updating Entity Templates

In order to prove that both entities *entity1* and *entity2* are still linked to the entity template *example.baseEntity* change the transform component of
the entity template and reload the scene. As you can see the entities are inheriting all the configuration from the template which is not included in their
instance configuration.

{@img creatingEntityTemplate5.png}


### Creating Entities based on Templates from Scripts

It goes without saying that entities based on templates can also be created dynamiclly through API calls. Just provide the additional attribute
*entityTemplateId* when calling the *createEntity* method. The provided attribute configuration overwrites the configuration from the entity template.

<pre><code>
spell.entityManager.createEntity(
	{
		entityTemplateId : "example.baseEntity",
		config : {
			"spell.component.2d.transform": {
				"scale" : [ 0.333, 0.333 ],
				"translation" : [ -50, -50 ]
			}
		}
	}
)
</pre></code>




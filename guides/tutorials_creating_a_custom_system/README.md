# Creating a custom system

This guide explains how a custom system is created from scratch and added to a scene.


## Defining the system

In order to create a system you first have to create a *system template*. The system template does three things.

1. It declares a library location (library namespace and id).
2. It declares the input for the system to process.
3. It declares the library dependencies of the system.


Here is an example of a system that adds a "gravity pull" behaviour to your game.


**Creating a gravity system template in the library view.**

{@img creatingGravitySystemTemplate.png creating the gravity system template in the library}


**The gravity system template configuration dialog.**

{@img showingGravitySystemTemplate.png configuration of the gravity system template}

As you can see in the input panel the gravity system processes all entities that have a *spell.component.visualObject* and *spell.component.2d.transform*
component. The associated system implementation is located in the script with the module id *example/gravity*.


## Implementing the system

Double click the gravity system template library record in order to open the system implementation view. The following code snippet provides a bare minimum
implementation for the gravity system.

<pre><code>
define(
	'example/gravity',
	function() {
		'use strict'


		var Gravity = function( spell ) {}

		Gravity.prototype = {
			init : function() {},
			destroy : function() {},
			activate : function() {},
			deactivate : function() {},
			process : function( spell, timeInMs, deltaTimeInMs ) {
				var deltaTimeInS  = deltaTimeInMs / 1000,
					gravityFactor = 5,
					transforms    = this.transforms,
					visualObjects = this.visualObjects

				// iterating over all entities which are visual objects
				for( var entityId in visualObjects ) {
					var transform = transforms[ entityId ]

					if( !transform ) {
						continue
					}

					// decrement the y component of the translation
					spell.entityManager.updateComponentAttribute(
						entityId,
						"spell.component.2d.transform",
						"translation",
						[ transform.translation[ 0 ], transform.translation[ 1 ] - deltaTimeInS * gravityFactor ]
					)
				}
			}
		}

		return Gravity
	}
)
</code></pre>


## Adding the system to a scene

Now you have to perform one final step to use the newly created system in your scene. First open the scenes view, right click on the systems node in the scene
tree on the left and chose "Add system". In the dialog that opens chose "render" as system type and check the box in front of the gravity system in the
"Available Systems" list and complete the process with a click on the "Add" button at the bottom.

**The scenes view**

{@img addingGravitySystemToScene.png adding the gravity system to the scene}


If you press the "Reload" button now the system should be active and all visible objects should be affected by the gravity pull. If you don not have any
visible entities in your scene just add a new entity with an appearance (spell.component.2d.graphics.appearance), transform (spell.component.2d.transform) and
visualOjbect (spell.component.visualObject) component.







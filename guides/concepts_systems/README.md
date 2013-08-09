# Systems

This guide illustrates the basic concept of systems in SpellJS. It is intended for developers who are new to the SpellJS framework.

You might also be interested in [this guide](#!/guide/intro_creating_a_system_from_scratch) about creating a system from scratch.


## What is a System?

In SpellJS entities do not have instance methods by design. However it is often desirable to equip entities with a certain behaviour.

The SpellJS way of tackling this issue is to create a system that takes care of managing the behaviour of a certain type of entity. Usually systems limit the
scope of entities that they process by declaring a group of entities as the expected input. This entity group consists of a set of components that an entity
instance must have in order to qualify as input for the system.


## System Definition

A system is declared in form of a system definition. The purpose of the system definition is to provide a unique identifier, to declare the
system's input and to assign a script which contains the system implementation.


## System Implementation

Since a system is implemented with a script all standard rules related to [script definition](#!/guide/concepts_scripts) apply.


### A basic system skeleton

<pre><code>
/**
 * @class ExampleSystem
 * @singleton
 */

define(
	'ExampleSystem',
	[
		'spell/functions'
	],
	function(
		_
	) {
		'use strict'


		/**
		 * Creates an instance of the system.
		 *
		 * @constructor
		 * @param {Object} [spell] The spell object.
		 */
		var ExampleSystem = function( spell ) {

		}

		ExampleSystem.prototype = {
			/**
		 	 * Gets called when the system is created.
		 	 *
		 	 * @param {Object} [spell] The spell object.
			 */
			init : function( spell ) {

			},

			/**
		 	 * Gets called when the system is destroyed.
		 	 *
		 	 * @param {Object} [spell] The spell object.
			 */
			destroy : function( spell ) {

			},

			/**
		 	 * Gets called when the system is activated.
		 	 *
		 	 * @param {Object} [spell] The spell object.
			 */
			activate : function( spell ) {

			},

			/**
		 	 * Gets called when the system is deactivated.
		 	 *
		 	 * @param {Object} [spell] The spell object.
			 */
			deactivate : function( spell ) {

			},

			/**
		 	 * Gets called to trigger the processing of game state.
		 	 *
			 * @param {Object} [spell] The spell object.
			 * @param {Object} [timeInMs] The current time in ms.
			 * @param {Object} [deltaTimeInMs] The elapsed time in ms.
			 */
			process : function( spell, timeInMs, deltaTimeInMs ) {

			}
		}

		return ExampleSystem
	}
)
</code></pre>


### Accessing Input

All components which are declared as input of a system in its system definition can be accessed by their local aliasing name as instance members in the
scope of the system. These data structures are called *component maps*. The injection of a *component map* into a system instance is performed by the engine
when a system is created. If for example a system declares the component *spell.component.2d.transform* with the local alias "myTransformComponents" as its
required input the *component map* of all transform components can be accessed through the this pointer as shown below.

<pre><code>
...

var ExampleSystem = function( spell ) {
	var transformComponents = this.myTransformComponents

	for( var entityId in transformComponents ) {
		var transform = transformComponents[ entityId ]

		spell.logger.debug( transform.translation )
	}
}

ExampleSystem.prototype = {
	...

	/**
	 * Gets called to trigger the processing of game state.
	 *
	 * @param {Object} [spell] The spell object.
	 * @param {Object} [timeInMs] The current time in ms.
	 * @param {Object} [deltaTimeInMs] The elapsed time in ms.
	 */
	process : function( spell, timeInMs, deltaTimeInMs ) {
		var transformComponents = this.myTransformComponents

		for( var entityId in transformComponents ) {
			var transform = transformComponents[ entityId ]

			drawOrigin( transform )
		}
	}
}

...
</code></pre>


### Component Map structure

The following example shows the structure of the *spell.component.2d.transform* component map. The data structure is shown in JSON notation. Note that the
keys of the map are entity ids. The associated objects are the component instances. In the example below only two entities with the ids 0 and 3
have a *spell.component.2d.transform* component. The actual structure of the transform component contains some additional attributes which where omitted for
brevity.

<pre><code>
{
	"0" : {
		"rotation" : 0,
		"scale" : [ 2, 2 ],
		"translation" : [ 0, 100 ]
	},
	"3" : {
		"rotation" : 1.57,
		"scale" : [ 1, 1 ],
		"translation" : [ 50, 50 ]
	}
}
</code></pre>


### Important notes about Component Maps

* **Do not rely on a certain iteration order.** Component maps are just regular JavaScript objects with the keys being entity ids and the values being the
component instances. As a consequence you must not make any assumptions about iteration order when iterating over the component map.

* **Try not to keep references to components.** It is not recommended to keep references to individual component instances in the system instance scope
between processing calls. Other systems might manipulate entities too, including the deletion of components or even the whole entity. If you really,
really feel the need to keep references to components make sure that they are either always valid or check them for validity before you perform processing on
 them.

* **Use the spell API to manipulate components and entities.** Manipulating component maps must not be done manually but rather through means provided by the
framework ([Creating entities dynamically](#!/guide/tutorials_creating_entities_dynamically)). *Otherwise things might break.*


## System Lifecycle

A system resides always in one of the four states *initial*, *inactive*, *active* or *final*. Transitions between these states are signaled by calls to the
respective event methods *init*, *activate*, *deactivate*, *destroy* and *process* (see the code example in the [System Implementation](#!/guide/concepts_systems-section-system-implementation) paragraph). It is recommended to place setup and tear-down operations which do not rely on entities
 to be placed in the *init* and *destroy* methods. Setup und tear-down operations which work on entities are implemented in the *activate* and *deactivate*
 methods. The *process* method should only contain the main processing operations. I.e. the render system performs the drawing of the scene in its *process*
 method.

{@img systemStatesDiagram.png system state diagram}


## System Execution


### Execution Order
The order in which systems are executed is important. The order can be changed during editing time but not during runtime. It is always guaranteed that changes performed by
*system A* to the game state are visible to *system B* when *system B* is set to execute after *system A* by the predefined order. If one of your systems relies on processing performed by another system make sure to schedule your system's execution after the
execution of the other system.


### Execution Group
Systems can be assigned to two different execution groups. Which one is better suited depends on the type of processing performed by the system.

The first group is called *render*. Systems assigned to this group are executed everytime a render tick is performed. The amount of render ticks might vary
depending on your concrete workload but will max out at about the refresh rate of the devices display. Usually only systems related to rendering should be
assigned to this type.

The other group is called *update*. Systems assigned to this group are executed every update tick. Update ticks are done periodically at a fixed rate of 50 Hz.

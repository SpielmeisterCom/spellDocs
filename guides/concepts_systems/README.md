# Systems

This guide illustrates the basic concept of systems in SpellJS. It is intended for developers who are new to the SpellJS framework.

You might also be interested in [this guide](#!/guide/intro_creating_a_system_from_scratch) about creating a system from scratch.


## What is a system?

In SpellJS entities do not have instance methods. This is intentionally and by design. However in a game engine it is desirable to associate a certain piece of
logic with a certain type of entity. Without being able to "pin" a certain piece of logic to an entity in order to describe its behaviour a developer would be
limited to creating purely static games which are considered not much fun to play by many players.

The SpellJS way of tackling this issue is to create a system that takes care of managing the behaviour of a certain type of entity. Usually systems limit the
scope of entities that they process by declaring a group of entities as the expected input. This entity group consists of a set of components that an entity
instance must have in order to qualify as input for the system.


## System definition

A system is declared in form of a system template. The purpose of the system template is to provide a unique identifier (namespace and name), to declare the
systems' input and to assign a script which contains the implementation.


## System implementation

Since a systems' implementation is done in a script all standard rules related to [script definition](#!/guide/concepts_scripts) apply.

### A basic system skeleton

<pre><code>
/**
 * @class Foo
 * @singleton
 */

define(
	'Foo',
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
		var Foo = function( spell ) {

		}

		Foo.prototype = {
			/**
		 	 * Gets called when the system is created.
		 	 *
		 	 * @param {Object} [spell] The spell object.
			 */
			init: function( spell ) {

			},

			/**
		 	 * Gets called when the system is destroyed.
		 	 *
		 	 * @param {Object} [spell] The spell object.
			 */
			destroy: function( spell ) {

			},

			/**
		 	 * Gets called when the system is activated.
		 	 *
		 	 * @param {Object} [spell] The spell object.
			 */
			activate: function( spell ) {

			},

			/**
		 	 * Gets called when the system is deactivated.
		 	 *
		 	 * @param {Object} [spell] The spell object.
			 */
			deactivate: function( spell ) {

			},

			/**
		 	 * Gets called to trigger the processing of game state.
		 	 *
			 * @param {Object} [spell] The spell object.
			 * @param {Object} [timeInMs] The current time in ms.
			 * @param {Object} [deltaTimeInMs] The elapsed time in ms.
			 */
			process: function( spell, timeInMs, deltaTimeInMs ) {

			}
		}

		return Foo
	}
)
</code></pre>


### Accessing input

All components which are declared as input for a system in its system template can be accessed by their local aliasing name as instance members of the system.
These data structures are called **component dictionaries**. The injection of a component dictionary into a system instance is done by the engine automatically
when a system gets created. If for example a system declares the component *spell.component.2d.transform* with the local alias "myTransformComponents" as its
required input the *component dictionary* of all transform components can be accessed through the this pointer as shown below.

<pre><code>
...

var Foo = function( spell ) {

    for (var entityId in this.myTransformComponents) {

        doSomethingWithEntityId( entityId )
    }

	//...
}

Foo.prototype = {
        /**
         * Gets called when the system is created.
         *
         * @param {Object} [spell] The spell object.
         */
        init: function( spell ) {

        },

        /**
         * Gets called when the system is destroyed.
         *
         * @param {Object} [spell] The spell object.
         */
        destroy: function( spell ) {

        },

        /**
         * Gets called when the system is activated.
         *
         * @param {Object} [spell] The spell object.
         */
        activate: function( spell ) {

        },

        /**
         * Gets called when the system is deactivated.
         *
         * @param {Object} [spell] The spell object.
         */
        deactivate: function( spell ) {

        },

        /**
         * Gets called to trigger the processing of game state.
         *
         * @param {Object} [spell] The spell object.
         * @param {Object} [timeInMs] The current time in ms.
         * @param {Object} [deltaTimeInMs] The elapsed time in ms.
         */
        process: function( spell, timeInMs, deltaTimeInMs ) {
		    _.each( this.myTransformComponents, function( component, entityId ) {
		        // do stuff
		     } )

        }
	}
}

...
</code></pre>


### Component dictionary structure

The following example shows the structure of the *spell.component.2d.transform* component dictionary. The data structure is shown in JavaScript object notation.
Note that the keys of the dictionary are entity ids. The associated values are the component instances. In the example only two entities with the ids 0 and 3
have a *spell.component.2d.transform* component.

<pre><code>
{
	0 : {
		rotation : 0,
		scale : [ 2, 2 ],
		translation : [ 0, 100 ]
	},
	3 : {
		rotation : 1.57,
		scale : [ 1, 1 ],
		translation : [ 50, 50 ]
	},
}
</code></pre>


### Working with component dictionaries

As stated before input is presented to a system in form of component dictionaries. There are a couple of things you should keep in mind when working with them.

* Component dictionaries are just regular JavaScript objects with the keys being entity ids and the value being the component instances. As a consequence you must
not make any assumptions about iteration order when iterating over the component dictionary.

* It is usually a very bad idea to keep references to individual component instances in the system instance scope around between two processing calls. This is
considered an anti pattern because other systems might also manipulate entities and their components. This manipulation includes the deletion of entities too.
So if another system decides that it is time to delete an entity whilst your system is still keeping a reference to one of its components you have successfully
entered side effect hell. Try to avoid this for your own sake.

* Manipulating component dictionaries must not be done manually but rather through means provided by the framework
([Creating entities dynamically](#!/guide/tutorials_creating_entities_dynamically)). Otherwise things might break.


## System execution

### Execution order
The order in which systems are executed is important. The order can be changed during editing time but not during runtime. It is always guaranteed that changes performed by
*system A* to the game state are visible to *system B* when *system B* is set to execute after *system A* by the predefined order. If one of your systems relies on processing performed by another system make sure to schedule your system's execution after the
execution of the other system.

### Execution group
Systems can be assigned to two different execution groups. Which one is better suited depends on the type of processing performed by the system.

The first group is called *render*. Systems assigned to this group are executed everytime a render tick is performed. The amount of render ticks might vary
depending on your concrete workload but will max out at about the refresh rate of the devices display. Usually only systems related to rendering should be
assigned to this type.

The other group is called *update*. Systems assigned to this group are executed every update tick. Update ticks are done periodically at a fixed rate of 50 Hz.

# Handling user input

This guide explains how to handle user input.


## Input manager

The input manager plays a central role in the handling of user input. It offers three different mechanism for handling input.


## Polling

The most straight forward method of handling input is to poll for changes.

<pre><code>
var inputManager = spell.inputManager

if( inputManager.isKeyPressed( inputManager.KEY.SPACE ) ) {
	// the key is currently pressed
}
</code></pre>


## Listening for input events

When polling for input changes is not an option a listener can be registered to process input events of a certain type.

<pre><code>
var processKeyDown = function( event ) {
	if( event.keyCode === spell.inputManager.KEY.SPACE ) {
		// do something clever

	} else if( event.keyCode === spell.inputManager.KEY.X ) {
		// do something else
	}
}

var processPointerMove = function( event ) {
	var pointerPosition = event.position

	highlight( pointerPosition )
}

spell.inputManager.addListener( 'keyDown', processKeyDown )
spell.inputManager.addListener( 'pointerMove', processPointerMove )
</code></pre>

Make sure to remove the listeners you registered once they are not needed anymore.

<pre><code>
spell.inputManager.removeListener( 'keyDown', processKeyDown )
spell.inputManager.removeListener( 'pointerMove', processPointerMove )
</code></pre>


## Mapping input with input contexts

In addition to *polling* and registering *listeners for input events* it is also possible to define a group of mapped inputs as an input context.

<pre><code>
var inputMapAsset = spell.assetManager.get( 'inputMap:myGame.myInputMapAsset' )

spell.inputManager.addInputContext( 'myInputContext', inputMapAsset )
</code></pre>

As you can see the input context is comprised of a unique string (i.e. 'myInputContext') to identify the input context and an asset of type "inputMap".

### Command dispatching with input contexts

An inputMap asset contains mappings between key inputs and commands. When a key input event occurs the input manager performs a look up in order to
determine if any of the available input contexts maps the input event to a command. When a mapped command is found it is then dispatched to all entities which
have the controllable component ("spell.component.controllable") with a controllerId attribute value of "player". The command event is then
dispatched to the respective event handler defined in the entities event handlers component ("spell.component.eventHandlers").

The following code example is an excerpt of the spacecraft behaviour script ("demo_asteroids.script.spacecraftBehaviour") from the *demo_asteroids* example
project. As you can see the accelerate command is dispatched to the startAccelerate and stopAccelerate functions depending on whether the command is
triggered through a keyDown or keyUp key event.

<pre><code>
startAccelerate : function( spell, entityId ) {
	var entityManager = spell.entityManager,
		spacecraft    = entityManager.getComponentById( entityId, spacecraftComponentId ),
		transform     = entityManager.getComponentById( entityId, Defines.TRANSFORM_COMPONENT_ID )

	if( !spacecraft || !transform ) {
		return
	}

	var rotation      = transform.rotation,
		thrusterForce = spacecraft.thrusterForce

	vec2.set(
		spacecraft.force,
		Math.sin( -rotation ) * thrusterForce,
		Math.cos( rotation ) * thrusterForce
	)
},
stopAccelerate : function( spell, entityId ) {
	var spacecraft = spell.entityManager.getComponentById( entityId, 'demo_asteroids.component.spacecraft' )

	vec2.set( spacecraft.force, 0, 0 )
}
</code></pre>





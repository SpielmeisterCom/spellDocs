# Scenes

This guide illustrates the basic concept of scenes in SpellJS. It is intended for developers who are new to the SpellJS framework.


## Scene Structure

A *scene* in SpellJS describes a specific configuration of entities and systems. A simple game might include only one or two scenes while more complex games
might include more. Typically scenes are used to divide the application into distinct sections. Each scene differing from the other by its scope. For
example in a simple tetris-like game one would probably find a "play level" and a "score screen" scene. Both scenes would only include entities and systems
relevant to the scope of the scene. The "update blocks" system would be included in the "play level" scene but not in the "score screen" scene.

A scene is comprised of a set of entities, a set of systems and a scene script. The entities contained in the scene configuration are also called "initial"
entities because they are created before the beginning of the execution of the scene. Entities can also be [created during execution](#!/guide/tutorials_creating_entities_dynamically)
of scene. The systems belonging to the scene are executed according to execution group and execution order. See the [Systems guide](#!/guide/concepts_systems-section-system-execution)
for details. The script associated with the scene is defined in a namespace corresponding to the location of the scene in the library.

The following screenshot shows a loaded project in SpellEd. The scene view on the left contains the scene *demo_box2d.scene.Scene1*.

{@img spellEdProjectOverview.png overview of a project in SpellEd}


## Scene Lifecycle

The lifecycle of a scene contains only one state - the active state. When a scene is created the *init* event method gets called. The *init* method is called
 after the entities contained in the scene are instantiated. The *destroy* event method is called before the existing entities are destroyed.

{@img sceneStates.png scene states diagram}


## Transitioning Between Scenes

In order to transition from the currently executed scene to a different scene the scene manager provides the changeScene method. Calling it with the library
id of the target scene starts the transition. During the transition the library dependencies referenced by the source scene are freed and the library
dependencies of the target scene are loaded.

<pre><code>
spell.sceneManager.changeScene( 'myGame.myOtherScene' )
</code></pre>


### Forwarding data to the target scene

Additional parameters can be forwarded to the target scene's *init* method by providing an additional argument to the changeScene method.

<pre><code>
spell.sceneManager.changeScene(
	'myGame.myOtherScene',
	{
		score : 120,
		lives : 3
	}
)
</code></pre>


### Using a loading scene

Depending on the library dependencies of the target scene the loading process can be noticeable. When no further steps are taken the screen will just stay
black during the scene transition period. This is usually undesireable because even short periods without feedback may lead the player to think that the game
 has crashed. Instead of the black screen a loading scene can be displayed. It is recommended to minimize the library dependencies of the loading scene to a
 minimum (the fewer textures/sounds the better) in order to keep the duration of the loading process of the loading scene as short as possible. The loading
 scene can then display an animation or progress indicator to keep the player updated.

For this to work the loading scene's library id must be set in the project configuration (set the key "loadingScene" to "myGame.myLoadingScene"). Performing
a scene transition via a loading scene is then accomplished by setting the third argument of changeScene to true. See [scene manager API](#!/api/spell.sceneManager-method-changeScene)
 for details.

<pre><code>
spell.sceneManager.changeScene( 'myGame.myOtherScene', undefined, true )
</code></pre>

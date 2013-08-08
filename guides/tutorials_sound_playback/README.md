# Sound playback

This guide explains how to play sound.


## Audio Context

Sound playback is controlled through the audio context. The audio context hides the sound playback implementation details of the different supported target
platforms behind [a single API](#!/api/spell.audioContext).


### Playing a sound

In order to play a sound effect it must be added to your project library as well as to the dependencies of the scene in which the playback should occur. In
the scope of the scene it is now possible to play the sound effect. See the [play](#!/api/spell.audioContext-method-play) method's documentation for more
details.

<pre><code>
spell.audioContext.play( spell.assetManager.get( 'sound:myGame.creakyNoise' ).resource )
</code></pre>

As you can see the sound asset is referenced by its asset id *sound:myGame.creakyNoise*. The play method expects an audio resource as its first argument.


### Controlling already playing sounds

When you want to control the playback of a sound an identifier must be assigned to it on the initial call to the *play* method. Sound ids must be unique in
order to make
sure that additional calls
affect the right sound.

<pre><code>
spell.audioContext.play( spell.assetManager.get( 'sound:myGame.owlHowl' ).resource )
spell.audioContext.play( spell.assetManager.get( 'sound:myGame.creakyNoise' ).resource, 'noise1' )

...

// creaky noise should be less loud
spell.audioContext.setVolume( 'noise1', 0.25 )
</code></pre>


### Looping a sound

Looping of sound playback is especially useful for background music or environmental sound (i.e. a radio).

<pre><code>
spell.audioContext.play( spell.assetManager.get( 'sound:myGame.dramaticOrgan' ).resource, 'music', 1.0, true )
</code></pre>




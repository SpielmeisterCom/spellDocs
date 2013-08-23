# SpellJS API

This guide explains how to use the SpellJS API for scripting.


## Introduction to the SpellJS API

The SpellJS engine consists of a multitude of [modules](#!/guide/concepts_scripting_basics). A defined subset of them are considered to be part of the public
API. Future changes to the public API which break backwards compatibility are going to be documented in a changelog. Changes to SpellJS modules which are not
 part of the public API will most likely not be documented.


## Accessing the Public API

The recommended method of accessing the public API is to use the *spell object*. You have most likely stumbled upon it when reading code examples in some of
the tutorials and asked yourself what purpose it serves. Some components of the SpellJS engine (i.e. EntityManager, LibraryManager, etc.) must be initialized
and assembled in a certain way. For the sake of usability the engine performs this task during initialization and stores the result in the *spell object*.

Examples:

<pre><code>
spell.entityManager.createEntity( {
	entityTemplateId : "breakableCrate"
} )

...

var vec2   = spell.math.vec2,
	result = vec2.create()

vec2.add( result, a, direction )
</code></pre>

Due to the nature of the module system that SpellJS uses it is not possible to only allow access to modules of the public API. Therefore developers can
include and use all modules even though they are not part of the public API. Just keep in mind that porting to future versions of the SpellJS API will become
 **increasingly harder** the more your code relies on non-public API functionality. It is best to just stick to the functionality provided by the *spell
 object* and your own auxiliary modules.


## Public API Documentation

The documentation of the public API is located right [here](#!/api).

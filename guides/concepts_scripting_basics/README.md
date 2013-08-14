# Scripting Basics

This guide explains the basics of scripting in SpellJS.


## Introduction

Even simple games require scripting of some level of custom behaviour. Handling user input, playing sounds or defining ai behaviour all imply the use of
scripts. This guide assumes a basic understanding of programming since writing scripts in SpellJS is effectively programming JavaScript code. The purpose
 of this guide is not to teach programming 101 but to illustrate important aspects that developers should be aware of when writing scripts for the SpellJS
 engine.


## What is a Script?

A script is basically a JavaScript AMD module limited to a subset of JavaScript syntax stuffed into a SpellJS project library record. Systems, event handlers,
component types or just collections of useful functions your game uses are all implemented in scripts. Scripts must adhere to following conventions.


### Scripts must be defined in a special module definition syntax

Scripts must be defined in a special syntax subset of the [AMD standard][1]. Only named modules (modules that define a module identifier) are supported. The
*define* function can be called with two or three arguments dependening on whether dependencies exist. The first argument is the module identifier. The module
identifier must always be unqiue. If a module identifier is used more than once executing or building the project will fail. When no dependencies exist the
dependencies array can be omitted. The last argument is always the module scope function. It gets the module dependencies pushed in as arguments in the same
order as they are defined in the dependencies array.

Here is an example of a module definition:

<pre><code>
define(
	'spell/math/util',
	[
		'spell/shared/util/platform/Types'
	],
	function(
		Types
	) {
		'use strict'

		...

		util.clamp = function( value, lowerBound, upperBound ) {
			if( value < lowerBound ) return lowerBound
			if( value > upperBound ) return upperBound

			return value
		}

		...

		return util
	}
)
</code></pre>


### Scripts should use ECMAScript 3 syntax

Using language features which were added after ECMAScript 3 might cause problems when building for targets other than the html5 sub-target. If you
nevertheless decide to do this or are forced to do it make sure that you test the builds for the desired targets frequently during development.


### Scripts must not manipulate the DOM (mostly)

Manipulating the DOM directly through scripting is technically possible for the html5 sub-target but will fail miserably when your code is executed on other
supported targets because the DOM is not available. The main purpose of the SpellJS engine is to abstract the user code from the underlying HTML5/DOM APIs.
So accessing the DOM directly kind of defeats the purpose of using the SpellJS framework in the first place. However if you are forced to do it (or just
really love jQuery) keep in mind that this breaks compatibility with targets other than the html5 sub-target. **This would effectively mean: no support for
mobile or flash builds.**


[1]: http://requirejs.org/docs/whyamd.html


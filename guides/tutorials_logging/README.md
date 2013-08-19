# Logging

This guide explains how to log messages to the spell console.


## Logging to the console

The SpellJS API includes a logging console. While it is possible to instantiate the class yourself it is usually not necessary to do so. The spell object
provides an instance of the class through its *console* attribute.

The console has support for different log levels which can be used to filter logged messages depending on the current mode of operation. For example when
certain messages are logged with the debug log level it is ensured that these messages are only shown when the projects is run in debug mode.

<pre><code>
// logging some generic information
spell.console.info( "generic information" )

// logging messages related to development
spell.console.debug( "debugging information" )
spell.console.error( "a critical error occured" )
</code></pre>


## Why the HTML console object should not be used

Accessing HTML browser environment features directly prevents the building of a project for targets other than the html5 sub-target. When build support for
other targets is required the native HTML console object must not be used.

# Overview

SpellJS is a cross-platform framework for the development of games based on the HTML5 technology stack. It offers a convenient abstraction layer that hides all
platform specific implementation details that exist on the various browser environments and mobile devices.


## Developing with SpellJS

The SpellJS engine is designed to work as a runtime for your content. This means that SpellJS can not be included as a library into your already existing
project on a source code level. Rather your SpellJS project consists of a collection of [scenes](#!/guide/concepts_scenes),
custom game objects called [entities](#!/guide/concepts_entities), associated behaviour implemented in [systems](#!/guide/concepts_systems) and [assets](#!/guide/concepts_assets).
For deployment your project is compiled into a runtime friendly representation during a build process. The resulting compiled package - the *application
module* - can then be executed by the SpellJS engine in a web browser or as a native app on mobile devices.

Developing a project with the SpellJS framework is done primarily in the SpellJS editor called *SpellEd*. SpellEd is an integrated development environment that
makes it easy to design complex scenes and define custom entities and entity behaviour. Creating and managing assets is also done in SpellEd. Custom behaviour
of entities is implemented in JavaScript code. The SpellJS framework offers a comprehensible API that alleviates the tasks often encountered during the
development of games.


## Development System Requirements

The development system must meet the following requirements:

* Windows, OS X or Linux (64 Bit)


## Supported Target Platforms

The following target platforms are supported out of the box, that means no additional work for porting to these platforms is necessary:

* Web browser - Chrome 22+, Safari 6+, Internet Explorer 10+, Firefox 18+, optional fall-back to Flash (10.1+)
* Android - version 2.3 or greater
* iOS - version 5 or greater

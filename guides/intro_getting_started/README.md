# Getting started with SpellJS

This guide covers the installation of the SpellJS framework and the initial steps in your first SpellJS project.


## Installation

### Obtaining a License

An unregistered version of the SpellJS framework offers only a limited set of features. Therefore it is recommended to obtain a free license (*free* as in
beer) which entitles you to a basic set of features. See the [license purchase](http://spelljs.com/buy) page for more details. The features included in the
free license are sufficient for testing as well as non commercial application.


### Downloading the SpellJS Framework

Go to the [download](http://spelljs.com/download) page and choose the installation package which matches your operating system. When the download has
finished proceed with the installation instructions according to your operating system.


#### Windows

Execute the installer you just downloaded and follow the provided installation instructions.


#### Linux

Unpack the archive you just downloaded to a location of your choosing. Then execute the binary *spelled* in the *spellEd* directory.

<pre><code>
mkdir spelljs
tar xzf spelljs-desktop-X.Y.Z-linux-x64.tar.gz -C spelljs
./spelljs/spellEd/spelled
</pre></code>


### SpellEd Interface Overview

The editor consists of several different components. Their names are shown here for future reference.

{@img interface1.png interface overview 1}
{@img interface2.png interface overview 2}


## Creating a Project

1. Start SpellEd - the SpellJS Editor.


2. Choose *Create new Project*

{@img firstSteps1.png creating a new project}

{@img firstSteps2.png entering a project name}

Now the new project is created and initialized. After this process is finished the project is ready for editing.


3. Now add an entity to the entities of the scene *test.Scene*. Right-click on the Entities node and choose *Add Entity* in the navigational tree in the
Scenes View.

{@img firstSteps3a.png}

Enter a name for the entity, for example *entity1*.

{@img firstSteps3b.png}


4. Select the entity you just created in the Scenes View and Add a couple of components to it.

{@img firstSteps4a.png}

Add the following three highlighted components to the entity.

{@img firstSteps4b.png}


5. Now presse the Reload button in the Main Toolbar to reload the active scene.

{@img firstSteps5a.png}

The entity you just added to the scene is now visible.

{@img firstSteps5b.png}



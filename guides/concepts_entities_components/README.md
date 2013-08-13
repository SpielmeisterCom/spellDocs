# Entities, Components and Systems

This guide defines the basic terms used in the SpellJS documentation. It is intended for developers who are new to the SpellJS framework.


## Framework Basics

### Entity

The term *entity* is commonly used to designate an object in the game world. The meaning of the term *object* should not be confused with the one commonly
associated with the object-oriented programming paradigm.

In the context of SpellJS an *entity* has the following properties:

* *not* an instance of a class
* an aggregation of components
* its identity consists solely of an *entity id*


### Component

In the context of SpellJS a *component* has the following properties:

* consists of structured data and setter/getter code
* can only exist in the context of an entity


### System

In the context of SpellJS a *system* has the following properties:

* processes components
* implements behaviour associated with components


### Entity Component System

An *entity component system* is a system that consists of entities, components and systems. It is a method of performing separation of data from logic
in a game engine. It should not be confused with the *system* mentioned previously which is a building block of the specific flavor of entity component system
implemented in SpellJS.


### Entity Templates

*Entity templates* are used to simplify the creation of entity instances. Entity templates come in handy especially if a specific entity configuration must
be editable in SpellEd while being used to instantiate entities at runtime. This is useful e.g. if a game designer working with SpellEd is fine tuning the
configuration of a certain type of entity without having to touch the underlying code.

The SpellJS framework provides a set of basic entities in the form of entity templates.


### Entity Id

The SpellJS engine uses entity ids to organize and identify entities. Similar to an SQL table's primary key they provide a unique identifier for every entity
 instance available in the system at one time. Dealing with entity ids is necessary when implementing your own systems in SpellJS.

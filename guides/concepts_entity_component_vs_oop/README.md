# Entity component system vs. OOP based system

This guide elaborates on the difference between *entity component systems* and *object-oriented systems* used in game engines. It is intended for developers
which are new to the idea of *entity component systems*. A background in object-oriented programming is recommended.


## The problem - deep inheritance hierarchies are hard

Usually developing non-trivial games with the default OOP approach means that all in-game objects inherit from a common base class. While new game object types
are added during development more and more data and logic is introduced into the game object inheritance hierarchy. Ultimately this process leads to the
occurrence of the [blob anti pattern][4].


## The solution - component decomposition, separating data from behaviour

It is generally accepted that the blob should be avoided. One way to achieve this is to do a *component decomposition* instead of an *object-oriented
decomposition* when coming up with the game object types. The component decomposition is similar to the object-oriented version. The main difference
 lies in the fact that common behaviour that was formerly aggregated into sub-classes in the inheritance hierarchy is now split into data - the component -
 and its accompanying behaviour - the system.

The result of this approach will be:

* a base of components that have a higher chance of being useful in another context
* a representation that expresses dependencies between data and behaviour explicitly by composition
* a code base that is easier to reason about


## Further reading

* [Evolve your hierarchy - Mick West][1]
* [Entity Systems are the future of MMOG development - t-machine.org][2]
* [Why use an entity framework for game development? - Richard Lord][3]


[1]: http://cowboyprogramming.com/2007/01/05/evolve-your-heirachy/ "Evolve your hierarchy - Mick West"
[2]: http://t-machine.org/index.php/2007/09/03/entity-systems-are-the-future-of-mmog-development-part-1/ "Entity Systems are the future of MMOG development - t-machine.org"
[3]: http://www.richardlord.net/blog/why-use-an-entity-framework "Why use an entity framework for game development? - Richard Lord"
[4]: http://en.wikipedia.org/wiki/God_object "God Object/The Blob"

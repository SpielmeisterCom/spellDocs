# Controllable (component template)

## Usage

The *Controllable* component is used to tag an entity for receiving input commands from the *processInputCommands* system. The input commands are dispatched
to event handlers implemented in the script referenced by the entity's enventHandlers component. Only *Controllable* components with a controllerId default
value of *player* receive input commands from the system.


## Attributes

### controllerId ( string, default: player )

The **controllerId** attribute value controls whether the entity receives input commands from the *processInputCommands* system. A value other than the default
can be used to flag the entity for other sources of input commands, i.e. an AI controller system.

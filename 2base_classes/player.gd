extends CharacterBody2D
class_name Player

# this is the base player script
# the class is simply to be used for identifying "player" objects
# that way, we can just check if something is Player
# thus, your player scripts should extend this, NOT CharacterBody2D
# if you are making a player that isn't a characterbody2d then just ignore this

## base suicide function, just here to avoid crashes
func suicide():
	push_error("NO FUNCTION SUICIDE FOUND IN PLAYER")

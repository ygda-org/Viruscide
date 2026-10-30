extends Node

# this script is not meant to be a global used everywhere. 
# Do not add to this script w/o permission.
# It is merely to keep track of the game's state

var strikes: int = 0

func failed_minigame():
	strikes += 1

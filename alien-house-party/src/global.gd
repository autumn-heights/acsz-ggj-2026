extends Node

# flag array
var flags: Array[String] = []
# e.g. ["has_cigarette", "can_talk_to_xyz"]

# stats
var stigma: int = 0
#var intox: int = 0
#var high: int = 0

# Navigation.
enum EDirection {NORTH, EAST, SOUTH, WEST}

var game_script: Dictionary

func has_flag(flag: String) -> bool:
	if flags.has(flag):
		return true
	return false

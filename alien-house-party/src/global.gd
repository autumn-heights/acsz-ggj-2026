extends Node

# flag array
var flags: Array[String] = []

# stats
var stigma: int = 0

# conversation tracking
var completed_dialogues: Array[String] = []

# Navigation.
enum EDirection {NORTH, EAST, SOUTH, WEST}

func has_flag(flag: String) -> bool:
	if flags.has(flag):
		return true
	return false
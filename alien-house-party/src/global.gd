extends Node

signal player_completed_move

enum RoomStates {KITCHEN, FOYER, RUMPUS, BEDROOM, BATHROOM, DINING, LAUNDRY, DOORWAY}
var current_room : RoomStates

# flag array
var flags: Array[String] = []

# stats
var stigma: int = 0

# conversation tracking
var completed_dialogues: Array[String] = []

# Navigation.
enum EDirection {NORTH, EAST, SOUTH, WEST}

var game_script: Dictionary

func has_flag(flag: String) -> bool:
	return flags.has(flag)

func on_player_complete_move(new_room : RoomStates):
	## called after player has finished moving from the "gamestatemanager"
	current_room = new_room
	## read what quests and if to trigger new interaction thingos here
	player_completed_move.emit()

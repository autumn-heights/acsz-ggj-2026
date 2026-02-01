extends Node
enum RoomStates {KITCHEN, FOYER, RUMPUS, BEDROOM, BATHROOM, DINING, LAUNDRY, DOORWAY}
var current_room : RoomStates
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

func on_player_complete_move(new_room : RoomStates):
	## called after player has finished moving from the "gamestatemanager"
	current_room = new_room
	## read what quests and if to trigger new interaction thingos here
	pass

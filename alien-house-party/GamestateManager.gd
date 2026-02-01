extends Node
<<<<<<< Updated upstream


=======
enum Gamestates {IDLE, MOVING, DIALOGUE}
enum RoomStates {KITCHEN, FOYER, RUMPUS, BEDROOM, BATHROOM, DINING, LAUNDRY}
var current_room : RoomStates
var current_state : Gamestates
@onready var map2d = $Layers2D
@onready var map3d = $Map3d
>>>>>>> Stashed changes
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_player_character_movement_state_changed(isMoving: bool, new_position : Vector2i) -> void:
	if !isMoving:
		map2d.update_map(new_position)
		var new_room = map2d.get_room_from_coords(new_position)
		## update where the player is on minimap
		## get the destinaion cell
		## pass it to the global
		Global.on_player_complete_move(new_room) ## trigger a function in global

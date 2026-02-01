extends Node
enum Gamestates {IDLE, MOVING, DIALOGUE}
var current_state : Gamestates
@onready var map2d = $Layers2D
@onready var map3d = $Map3d
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	map3d.digest_map(map2d.map_layer, map2d.floors)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

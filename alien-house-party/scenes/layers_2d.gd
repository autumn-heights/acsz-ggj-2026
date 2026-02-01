extends Node2D
class_name TileLayers

var locations_dict = {
	"mapBlockers":[],
	"questLocations":[]
}
var thing_dict = {
	Vector2i(0,0):"character",
	Vector2i(1,0):"quest",
	Vector2i(2, 0):"blocker",
}
var room_dict = {
	"kitchen": Vector2i(0, 4),
	"bathroom": Vector2i(0, 5),
	"rumpus": Vector2i(2, 4),
	"foyer": Vector2i(1, 4),
	"bedroom": Vector2i(3, 4),
	"dining": Vector2i(1,5),
}
@export var walls : TileMapLayer
@export var floors : TileMapLayer
@export var special_tiles :TileMapLayer
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func get_neighbor():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func digest_map():
	for cell in special_tiles.get_used_cells():
		var cell_atlas_coords = special_tiles.get_cell_atlas_coords(cell)
		if thing_dict.keys().has(cell_atlas_coords):
			match thing_dict.cell_atlas_coords:
				"blocker": locations_dict.mapBlockers.append(cell)
				"quest": locations_dict.questLocations.append(cell)
				"character": pass
				"":printerr("thing dict missing value ", cell_atlas_coords)
	
func update():
	pass

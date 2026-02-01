extends Node2D
class_name TileLayers

var locations_dict = {
	"mapBlockers":[],
	"questLocations":[],
	"player":Vector2i()
}
var thing_dict = {
	"player":Vector2i(0,0),
	"quest":Vector2i(1,0),
	"blocker":Vector2i(2, 0),
}

var room_dict = {
	Global.RoomStates.KITCHEN: Vector2i(0, 4),
	Global.RoomStates.BATHROOM: Vector2i(0, 5),
	Global.RoomStates.RUMPUS: Vector2i(2, 4),
	Global.RoomStates.FOYER: Vector2i(1, 4),
	Global.RoomStates.BEDROOM: Vector2i(3, 4),
	Global.RoomStates.DINING: Vector2i(1,5),
	Global.RoomStates.LAUNDRY: Vector2i(2, 5)
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
			for key in thing_dict:
				if thing_dict[key] == cell_atlas_coords:
					match key:
						"blocker": locations_dict.mapBlockers.append(cell)
						"quest": locations_dict.questLocations.append(cell)
						"player": locations_dict.append(cell)
						"":printerr("thing dict missing value ", cell_atlas_coords)

func update_map(player_pos):
	special_tiles.set_cell(locations_dict.player, -1)
	special_tiles.set_cell(player_pos, 0, thing_dict.player)
	locations_dict.player = player_pos
	
func get_room_from_coords(coords):
	var tile_id = floors.get_cell_atlas_coords(coords)
	print(tile_id)
	return get_tilename_from_atlas_coords(coords)

func get_tilename_from_atlas_coords(atlas_coords):
	for key in room_dict.keys():
		if room_dict[key] == atlas_coords:
			return key
	printerr("roomdict missing cell with coords: ", atlas_coords)

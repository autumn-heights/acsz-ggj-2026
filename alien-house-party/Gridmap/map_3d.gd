extends Node3D

var tiledict = {
	"Cube": Vector2i(0, 0),
	"Cube_001": Vector2i(1, 0),
	"Cube_002": Vector2i(2, 0),
	"Cube_003": Vector2i(3, 0),
	"Cube_004": Vector2i(4, 0),
	"Cube_005": Vector2i(5, 0),
	"Cube_006": Vector2i(6, 0),
	"Cube_007": Vector2i(7, 0),
	"Cube_008": Vector2i(8, 0),
	"Cube_009": Vector2i(9, 0),
	"Cube_010": Vector2i(10, 0),
	"Cube_011": Vector2i(11, 0),

	"Cube_012": Vector2i(0, 1),
	"Cube_013": Vector2i(1, 1),
	"Cube_014": Vector2i(2, 1),
	"Cube_015": Vector2i(3, 1),
	"Cube_016": Vector2i(4, 1),
	"Cube_017": Vector2i(5, 1),
	"Cube_018": Vector2i(6, 1),
	"Cube_019": Vector2i(7, 1),
	"Cube_020": Vector2i(8, 1),
	"Cube_021": Vector2i(9, 1),
	"Cube_022": Vector2i(10, 1),
	"Cube_023": Vector2i(11, 1),

	"Cube_024": Vector2i(0, 2),
	"Cube_025": Vector2i(1, 2),
	"Cube_026": Vector2i(2, 2),
	"Cube_027": Vector2i(3, 2),
	"Cube_028": Vector2i(4, 2),
	"Cube_029": Vector2i(5, 2),
	"Cube_030": Vector2i(6, 2),
	"Cube_031": Vector2i(7, 2),
	"Cube_032": Vector2i(8, 2),
	"Cube_033": Vector2i(9, 2),
	"Cube_034": Vector2i(10, 2),
	"Cube_035": Vector2i(11, 2),

	"Cube_036": Vector2i(0, 3),
	"Cube_037": Vector2i(1, 3),
	"Cube_038": Vector2i(2, 3),
	"Cube_039": Vector2i(3, 3),
	"Cube_040": Vector2i(4, 3),
	"Cube_041": Vector2i(5, 3),
	"Cube_042": Vector2i(6, 3),
	"Cube_043": Vector2i(7, 3),
	"Cube_044": Vector2i(8, 3),
	"Cube_045": Vector2i(9, 3),
	"Cube_046": Vector2i(10, 3),
	"Cube_047": Vector2i(11, 3)
}


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func digest_map(walls:TileMapLayer, floors:TileMapLayer):
	#walls.
	var wall_cells = walls.get_used_cells()
	for cell in wall_cells:
		print(cell, " ")
		place_mesh(walls.get_cell_atlas_coords(cell), cell)

func place_mesh(dict_key: Vector2i, map_pos: Vector2i):
	var mesh_name = get_mesh_name(dict_key)
	var pos3 = Vector3i(map_pos.x, 0, map_pos.y) ## vector2 -> Vector3
	print(mesh_name, " ", dict_key)
	var cell_id = mesh_library.find_item_by_name(mesh_name)
	if cell_id == null:
		printerr(mesh_library, " missing mesh with name ", mesh_name)
		return
	set_cell_item(pos3, cell_id)

func get_mesh_name(dict_key: Vector2i):
	for key in tiledict.keys():
		if tiledict[key] == dict_key:
			return key
	printerr("failed to find /n", dict_key, " /n in dict: /n", tiledict)
	return 

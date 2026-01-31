extends GridMap

var tiledict = {
	Vector2i(0, 0): "Cube",
	Vector2i(0, 1): "Cube_001",
	Vector2i(0, 2): "Cube_002",
	Vector2i(0, 3): "Cube_003",
	Vector2i(0, 4): "Cube_004",
	Vector2i(0, 5): "Cube_005",
	Vector2i(0, 6): "Cube_006",
	Vector2i(0, 7): "Cube_007",
	Vector2i(0, 8): "Cube_008",
	Vector2i(0, 9): "Cube_009",
	Vector2i(0, 10): "Cube_010",
	Vector2i(0, 11): "Cube_011",

	Vector2i(1, 0): "Cube_012",
	Vector2i(1, 1): "Cube_013",
	Vector2i(1, 2): "Cube_014",
	Vector2i(1, 3): "Cube_015",
	Vector2i(1, 4): "Cube_016",
	Vector2i(1, 5): "Cube_017",
	Vector2i(1, 6): "Cube_018",
	Vector2i(1, 7): "Cube_019",
	Vector2i(1, 8): "Cube_020",
	Vector2i(1, 9): "Cube_021",
	Vector2i(1, 10): "Cube_022",
	Vector2i(1, 11): "Cube_023",

	Vector2i(2, 0): "Cube_024",
	Vector2i(2, 1): "Cube_025",
	Vector2i(2, 2): "Cube_026",
	Vector2i(2, 3): "Cube_027",
	Vector2i(2, 4): "Cube_028",
	Vector2i(2, 5): "Cube_029",
	Vector2i(2, 6): "Cube_030",
	Vector2i(2, 7): "Cube_031",
	Vector2i(2, 8): "Cube_032",
	Vector2i(2, 9): "Cube_033",
	Vector2i(2, 10): "Cube_034",
	Vector2i(2, 11): "Cube_035",

	Vector2i(3, 0): "Cube_036",
	Vector2i(3, 1): "Cube_037",
	Vector2i(3, 2): "Cube_038",
	Vector2i(3, 3): "Cube_039",
	Vector2i(3, 4): "Cube_040",
	Vector2i(3, 5): "Cube_041",
	Vector2i(3, 6): "Cube_042",
	Vector2i(3, 7): "Cube_043",
	Vector2i(3, 8): "Cube_044",
	Vector2i(3, 9): "Cube_045",
	Vector2i(3, 10): "Cube_046",
	Vector2i(3, 11): "Cube_047"
}

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func place_mesh(dict_key: Vector2i, map_pos: Vector2i):
	var mesh_name = get_mesh_name(dict_key)
	var pos3 = Vector3i(map_pos.x, 0, map_pos.y) ## vector2 -> Vector3
	
	var cell_id = mesh_library.find_item_by_name(mesh_name)
	if cell_id == null:
		printerr(mesh_library, " missing mesh with name ", mesh_name)
		return
	set_cell_item(pos3, cell_id)
	

func get_mesh_name(dict_key: Vector2i):
	for t_pos in tiledict.keys():
		if t_pos == dict_key:
			return tiledict[dict_key]
	printerr("failed to find /n", dict_key, " /n in dict: /n", tiledict)
	return 

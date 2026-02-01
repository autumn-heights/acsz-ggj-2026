@tool

extends Node3D
@export var gridmap :GridMap
@export var tileLayers : TileLayers
#@onready var tileLayers: TileLayers = $"../Layers2D"
@export var alt_grid :GridMap
@export var digest = false:
	set(d):
		digest = d
		print(d)
		if d:
			print("placing grid")
			digest_tiles()
		else:
			if gridmap != null:
				print("clearing gridmap")
				gridmap.clear()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

var scan_limit = 20
enum meshlist {wall, floor, door}
enum special_meshlist {blocker, quest}
func digest_tiles():
	#var cards = [Vector2i.UP, Vector2i.RIGHT, Vector2i.DOWN, Vector2i.LEFT]
	if tileLayers == null:
		printerr("missing tilelayers")
		return
	if gridmap == null:
		printerr("missing gridmap")
		return
	if gridmap.mesh_library == null:
		print("grid meshes missiing")
		return
	var active_tilemap = tileLayers.walls
	var wall_cells = active_tilemap.get_used_cells()
	var floor_cells = tileLayers.floors.get_used_cells()
	#print(wall_cells)
	place_cells(tileLayers.walls, meshlist.wall)
	place_cells(tileLayers.floors, meshlist.floor)
	if alt_grid != null && alt_grid.mesh_library != null:
		
		for cell in tileLayers.special_tiles.get_used_cells():
			var atlascoord = tileLayers.special_tiles.get_cell_atlas_coords(cell)
			var p = Vector3i(cell.x, 0, cell.y)
			if atlascoord == Vector2i(2, 0):
				alt_grid.set_cell_item(p, special_meshlist.blocker)
				pass
			elif atlascoord == Vector2i(1,0):
				alt_grid.set_cell_item(p, special_meshlist.quest)
	else:
		printerr("altgrid is missing or its meshlib is empty")
	
	#for cell in wall_cells:
		#for d in cards:
		#	var i = 1
		#	while i > scan_limit:
		#		var p = cell + i * d
		#		if wall_cells.has(p):
		#			continue
		#		gridmap.set_cell_item(p, meshlist.floor)
		#		i += 1
func place_cells(tmap_layer:TileMapLayer, tile:int):
	var cells = tmap_layer.get_used_cells()
	var o = 0 
	for cell in cells:
		var ntile = tile
		var a_cord = tmap_layer.get_cell_atlas_coords(cell)
		if a_cord == Vector2i(5, 5) || a_cord == Vector2i(6, 5):
			ntile = meshlist.floor
			#if a_cord == Vector2i(5, 5):
			#	o = 22
			#ntile = meshlist.door
		var pos = Vector3i(cell.x, 0, cell.y)
		gridmap.set_cell_item(pos, ntile, o)

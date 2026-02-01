extends Node2D

@onready var tiles: TileMapLayer = $"../../TileLayer1"
@onready var playerCharacter: Node3D = $".."

# SIGNALS.
signal direction_changed(direction)
signal character_moved(newX, newY)

# NAVIGATION/DIRECTION Variables.
var direction = Global.EDirection.NORTH
# True values for tile coordinates for tracking tile-based location and translation with world space.
var tileX: int = 0
var tileY: int = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _input(event):
	if playerCharacter.isMoving == false:
		if event.is_action_pressed("up"):
			navigationUp()
		#if event.is_action_pressed("down"): No backwards movement for now.
		#	navigationDown()
		if event.is_action_pressed("left"):
			navigationLeft()
		if event.is_action_pressed("right"):
			navigationRight()

func navigationUp():
	# Attempt to move forward in the current direction.
	var newTileX = tileX
	var newTileY = tileY
	match direction:
		Global.EDirection.NORTH:
			newTileY -= 1
		Global.EDirection.EAST:
			newTileX += 1
		Global.EDirection.SOUTH:
			newTileY += 1
		Global.EDirection.WEST:
			newTileX -= 1
	
	var currentTile = Vector2i(tileX, tileY)
	var targetTile = Vector2i(newTileX, newTileY)
	
	var targetTileData: TileData = tiles.get_cell_tile_data(targetTile)
	# Check if the tile we're attempting to move to is walkable.
	if targetTileData == null:
		print("Attempted movement to non walkable tile, returning.")
		return
	
	# If it is walkable, we update our tile position here, and emit to tell the player character
	# the new worldspace coordinates it should go to.
	tileX = newTileX
	tileY = newTileY
	character_moved.emit(XToWorldSpace(), YToWorldSpace())
	
func navigationDown():
	# Attempt to move backwards.
	match direction:
		Global.EDirection.NORTH:
			tileY -= 1
		Global.EDirection.EAST:
			tileX -= 1
		Global.EDirection.SOUTH:
			tileY += 1
		Global.EDirection.WEST:
			tileX += 1
	character_moved.emit(XToWorldSpace(), YToWorldSpace())

func navigationLeft():
	# Rotate to face the direction to the left.
	match direction:
		Global.EDirection.NORTH:
			direction = Global.EDirection.WEST
		Global.EDirection.EAST:
			direction = Global.EDirection.NORTH
		Global.EDirection.SOUTH:
			direction = Global.EDirection.EAST
		Global.EDirection.WEST:
			direction = Global.EDirection.SOUTH
	direction_changed.emit(direction)

func navigationRight():
	# Rotate to face the direction to the right.
	match direction:
		Global.EDirection.NORTH:
			direction = Global.EDirection.EAST
		Global.EDirection.EAST:
			direction = Global.EDirection.SOUTH
		Global.EDirection.SOUTH:
			direction = Global.EDirection.WEST
		Global.EDirection.WEST:
			direction = Global.EDirection.NORTH
	direction_changed.emit(direction)

# These functions should translate the tile they are on to world space coordinates.
# Right now it seems each tile is just 2 units apart.
func XToWorldSpace() -> int:
	return tileX * 2

func YToWorldSpace() -> int:
	return tileY * 2

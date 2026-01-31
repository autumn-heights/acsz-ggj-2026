extends Node2D

# SIGNALS.
signal direction_changed(direction)
signal character_moved(newX, newY)

# NAVIGATION/DIRECTION Variables.
enum EDirection {NORTH, EAST, SOUTH, WEST}
var direction: EDirection = EDirection.NORTH
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
		if event.is_action_pressed("up"):
			navigationUp()
		if event.is_action_pressed("down"):
			navigationDown()
		if event.is_action_pressed("left"):
			navigationLeft()
		if event.is_action_pressed("right"):
			navigationRight()

func navigationUp():
	# Attempt to move forward in the current direction.
	match direction:
		EDirection.NORTH:
			tileY += 1
		EDirection.EAST:
			tileX += 1
		EDirection.SOUTH:
			tileY -= 1
		EDirection.WEST:
			tileX -= 1
	character_moved.emit(tileX, tileY)
	pass
	
func navigationDown():
	# Attempt to move backwards.
	match direction:
		EDirection.NORTH:
			tileY -= 1
		EDirection.EAST:
			tileX -= 1
		EDirection.SOUTH:
			tileY += 1
		EDirection.WEST:
			tileX += 1
	character_moved.emit(tileX, tileY)
	pass

func navigationLeft():
	# Rotate to face the direction to the left.
	match direction:
		EDirection.NORTH:
			direction = EDirection.WEST
		EDirection.EAST:
			direction = EDirection.NORTH
		EDirection.SOUTH:
			direction = EDirection.EAST
		EDirection.WEST:
			direction = EDirection.SOUTH
	direction_changed.emit(direction)
	pass

func navigationRight():
	# Rotate to face the direction to the right.
	match direction:
		EDirection.NORTH:
			direction = EDirection.EAST
		EDirection.EAST:
			direction = EDirection.SOUTH
		EDirection.SOUTH:
			direction = EDirection.WEST
		EDirection.WEST:
			direction = EDirection.NORTH
	direction_changed.emit(direction)
	pass

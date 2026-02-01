extends Node3D

var characterHeight: float = 3 # The character's height.
var player_position_2D : Vector2i
var isMoving: bool = false
signal MovementStateChanged(state, player_position_2D)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func OnCharacterMoved(newX: Variant, newY: Variant) -> void:
	# 2D navigator should probably be the one to translate movement between grid and world space,
	# this function just uses those values to physically move the character.
	#position = Vector3(newX, characterHeight, newY) # Translating from 2d to 3d, we use the 2d Y as 3d Z.
	isMoving = true
	MovementStateChanged.emit(isMoving)
	var tweenStep: Tween = create_tween()
	tweenStep.tween_property(self, "position",  Vector3((position.x + ((newX - position.x)/2)), (characterHeight + 0.5), (position.z + ((newY - position.z)/2))), 0.2)
	tweenStep.tween_property(self, "position",  Vector3(newX, characterHeight, newY), 0.2)
	player_position_2D = Vector2i(newX, newY) ## save where the player is moving to
	tweenStep.tween_callback(OnFinishedMove)
	
	# Lets print the new position out too, just so we know :)
	print(newX, newY)

func OnDirectionChanged(direction: Variant) -> void:
	# Face in the new direction.
	var newDirection: float = 0
	match direction:
		Global.EDirection.NORTH:
			#rotation_degrees = Vector3(0, 0, 0)
			newDirection = 0
		Global.EDirection.EAST:
			#rotation_degrees = Vector3(0, -90, 0)
			newDirection = -90
		Global.EDirection.SOUTH:
			#rotation_degrees = Vector3(0, -180, 0)
			newDirection = -180
		Global.EDirection.WEST:
			#rotation_degrees = Vector3(0, -270, 0)
			newDirection = -270
	
	isMoving = true
	MovementStateChanged.emit(isMoving)
	var tweenTurn: Tween = create_tween()
	var newRotation = lerp_angle(rotation.y, deg_to_rad(newDirection), 1)
	tweenTurn.tween_property(self,"rotation:y", newRotation, 0.2)
	tweenTurn.tween_callback(OnFinishedMove)

func OnFinishedMove():
	isMoving = false
	MovementStateChanged.emit(isMoving, player_position_2D)


func _on_d_navigator_location_initialised(startingX: Variant, startingY: Variant) -> void:
	position = Vector3(startingX, characterHeight, startingY)

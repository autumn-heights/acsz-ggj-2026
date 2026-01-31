extends Node3D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func OnCharacterMoved(newX: Variant, newY: Variant) -> void:
	# 2D navigator should probably be the one to translate movement between grid and world space.
	pass # Replace with function body.


func OnDirectionChanged(direction: Variant) -> void:
	# Command the camera from here to face in the new direction.
	pass # Replace with function body.

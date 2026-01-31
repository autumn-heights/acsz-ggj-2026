extends Node2D

var characterTween : Tween

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func pop_character():
	var ctr = get_viewport_rect().get_center()
	

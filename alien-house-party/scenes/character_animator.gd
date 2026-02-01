extends Node2D

var characterTween : Tween
@onready var sprite_node = $CharacterSprite

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func animate_character(showing):
	if characterTween:
		characterTween.kill() ## pauses existing running animator
	characterTween = create_tween().set_trans(Tween.TRANS_CUBIC)
	if showing:
		characterTween.set_trans(Tween.TRANS_BOUNCE)
		var characterHeight = sprite_node.get_rect().size.y
		var s = get_viewport_rect().size
		var p = Vector2()
		p.x = s.x / 2 ## getting the center of the viewport
		p.y = s.y + characterHeight
		p += get_viewport_rect().position
		var d = p ## setting sprite destination
		d.y -= characterHeight *1.5
		sprite_node.position = p
		sprite_node.modulate = Color.WHITE
		sprite_node.show()
		characterTween.tween_property(sprite_node, "position", d, 1.2)
	else:
		characterTween.set_ease(Tween.EASE_OUT)
		characterTween.tween_property(sprite_node, "modulate",
		Color(1, 1, 1, 0), 3.0)
		characterTween.tween_callback(sprite_node.hide)
	characterTween.tween_callback(characterTween.kill)

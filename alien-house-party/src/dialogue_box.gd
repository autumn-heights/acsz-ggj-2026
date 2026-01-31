extends Node2D

@export var dialogue_box_width: int = 500
@export var dialogue_box_height: int = 200
@export var dialogue_box_padding: int = 20

@onready var bg = %DialogueBoxBg
@onready var label = %DialogueBoxLabel

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	bg.size = Vector2(dialogue_box_width, dialogue_box_height);
	label.size = Vector2(dialogue_box_width - dialogue_box_padding*2, dialogue_box_height - dialogue_box_padding*2)
	label.position = Vector2(dialogue_box_padding, dialogue_box_padding)
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

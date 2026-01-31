extends Node2D

signal dialogue_advance

@export var dialogue_box_width: int = 700
@export var dialogue_box_height: int = 200
@export var dialogue_box_padding: int = 20
@export var dialogue_box_color: Color = "#bfff3c"

@export var current_text: String = "example text here textextextetxxtetxt"
@export var current_display_time: float = 0;
@export var max_line_length: int = 30; # in chars
@export var ready_to_advance: bool = 0;
@export var text_print_speed: float = 10.0; #in chars per second


var display_text_dict: Dictionary = {"is_complete": true, "text":"text"};

@onready var bg = %DialogueBoxBg
@onready var advance_button = %AdvanceButton
@onready var label = %DialogueBoxLabel

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	bg.size = Vector2(dialogue_box_width, dialogue_box_height);
	label.size = Vector2(dialogue_box_width - dialogue_box_padding*2, dialogue_box_height - dialogue_box_padding*2)
	label.position = Vector2(dialogue_box_padding, dialogue_box_padding)
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	current_display_time += delta;
	display_text_dict = _get_frame_displayed_text()
	label.text = display_text_dict["text"]
	ready_to_advance = display_text_dict["is_complete"]
	if ready_to_advance:
		advance_button.visible = true;
	
func set_new_text(new_text: String):
	current_text = new_text
	current_display_time = 0
	advance_button.visible = false
	
func set_new_color(new_color: Color):
	dialogue_box_color = new_color
	bg.color = new_color
	
# return format:
# { 
#	"is_complete": false,
#	"text: "My awesome dialo"
# }
func _get_frame_displayed_text() -> Dictionary:
	var total_chars = len(current_text);
	var num_chars_to_display = min(
			total_chars,
			int ( current_display_time * text_print_speed )
		);
	return {
		"is_complete": total_chars == num_chars_to_display,
		"text":current_text.substr(0,num_chars_to_display) 
	}
	
	
func _on_advance_button_pressed() -> void:
	print('dialogue_advance!!!')
	dialogue_advance.emit();

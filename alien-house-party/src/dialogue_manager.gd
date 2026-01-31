extends Node

var json_data: Dictionary
var console_label: Label
var choice_container: VBoxContainer

var current_script_id: String
var current_line_id: int = -1;
var num_lines_in_current_script: int = -1;

@onready var dialogue_box = %DialogueBox
@onready var npc_portrait = %NPCPortrait

const npc_textures = {
	"attendees_sprite_crushed1.png":
		preload("res://assets/attendees/attendees_sprite_crushed1.png"),
	"attendees_sprite_crushed2.png":
		preload("res://assets/attendees/attendees_sprite_crushed2.png"),
	"attendees_sprite_crushed3.png":
		preload("res://assets/attendees/attendees_sprite_crushed3.png"),
	"attendees_sprite_crushed4.png":
		preload("res://assets/attendees/attendees_sprite_crushed4.png"),
	"attendees_sprite_crushed5.png":
		preload("res://assets/attendees/attendees_sprite_crushed5.png"),
	"attendees_sprite_crushed6.png":
		preload("res://assets/attendees/attendees_sprite_crushed6.png"),
	"attendees_sprite_crushed7.png":
		preload("res://assets/attendees/attendees_sprite_crushed7.png"),
	"attendees_sprite_crushed8.png":
		preload("res://assets/attendees/attendees_sprite_crushed8.png"),
	"attendees_sprite_crushed9.png":
		preload("res://assets/attendees/attendees_sprite_crushed9.png"),
	"attendees_sprite_crushed10.png":
		preload("res://assets/attendees/attendees_sprite_crushed10.png"),
	"attendees_sprite_crushed11.png":
		preload("res://assets/attendees/attendees_sprite_crushed11.png"),
}

func load_json_file(path: String) -> void:
	var json_string: String = FileAccess.get_file_as_string(path)
	var parse_result = JSON.parse_string(json_string) 
	json_data = parse_result

func start_dialogue(script_id: String):
	# CNTODO: look up the ID in the dict and decide whether
	# to call display text or display choice
	
	if json_data[script_id]["type"] == "talking":
		
		current_script_id = script_id;
		current_line_id = 0
		dialogue_box.visible = true;
		num_lines_in_current_script = len(json_data[script_id]["lines"])
		display_text(json_data[script_id]["lines"][0]["text"])
		
	
	elif json_data[script_id]["type"] == "choice":
		
		pass
		
		# TODO: display the choice options on the screen
	
	pass

func _on_advance_dialogue():
	# FUNCTION THAT GETS TRIGGERED WHEN THE PLAYER ADVANCES THE DIALOGUE BOX
	# TODO: if there's another line of dialogue to display, then do that
	# TODO: if there's not another line of dialogue to display, then close the dialogue box
	if current_line_id < num_lines_in_current_script - 1:
		current_line_id += 1
		display_text(json_data[current_script_id]["lines"][current_line_id]["text"])
	pass

func display_text(data: String):
	dialogue_box.set_new_text(data);
	
func display_npc_portrait(data: String):
	npc_portrait.texture = npc_textures[data]

func display_choice(data):
	for child in choice_container.get_children():
		child.queue_free()
	
	for i in range(data["choices"].size()):
		var choice = data["choices"][i]
		var button = Button.new()
		button.text = choice["text"]
		button.pressed.connect(_on_choice_pressed.bind(choice))        
		choice_container.add_child(button)

func check_requirements(choice_data):
	pass

func handle_choice_selection(choice_data):
	
	# roll random number 1-6 compare against data
	# call start_dialogue with pass or fail
	pass

func end_dialogue():
	pass


func _ready():
	choice_container = VBoxContainer.new()
	choice_container.position = Vector2(10, 400)
	add_child(choice_container)
	console_label = Label.new()
	console_label.position = Vector2(10, 10)
	console_label.size = Vector2(800, 600)
	add_child(console_label)
	
	choice_container = VBoxContainer.new()
	choice_container.position = Vector2(10, 400)
	add_child(choice_container)
	
	console_label.text = "test"
	
	load_json_file("res://script.json")
	
	if json_data:
		print("LOADED SCRIPT: ", json_data)
	
	dialogue_box.dialogue_advance.connect(_on_advance_dialogue)
		


func _on_choice_pressed(choice_data):
	#handle_choice_selection(choice_data)
	for child in choice_container.get_children():
		child.queue_free()


func _process(delta: float) -> void:
	pass


func _on_debug_convo_button_pressed() -> void:
	start_dialogue("dialogue_1");

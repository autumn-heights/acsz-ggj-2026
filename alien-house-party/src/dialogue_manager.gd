extends Node

var json_data: Dictionary
var console_label: Label
var choice_container: VBoxContainer

var current_script_id: String
var current_line_id: int = -1;
var num_lines_in_current_script: int = -1;

@onready var dialogue_box = %DialogueBox

func load_json_file(path: String) -> void:
	var json_string: String = FileAccess.get_file_as_string(path)
	var parse_result = JSON.parse_string(json_string) 
	json_data = parse_result

func start_dialogue(script_id: String):
	# CNTODO: look up the ID in the dict and decide whether
	# to call display text or display choice
	
	if json_data[script_id]["type"] = "talking":
		
		current_script_id = script_id;
		dialogue_box.visible = true;
		num_lines_in_current_script = len(json_data[script_id]["lines"])
		
	
	else if json_data[script_id]["type"] = "choice":
	
	
	pass

func _on_advance_dialogue():
	# FUNCTION THAT GETS TRIGGERED WHEN THE PLAYER ADVANCES THE DIALOGUE BOX
	# TODO: if there's another line of dialogue to display, then do that
	# TODO: if there's not another line of dialogue to display, then close the dialogue box

func display_text(data: String):
	pass

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
		


func _on_choice_pressed(choice_data):
	#handle_choice_selection(choice_data)
	for child in choice_container.get_children():
		child.queue_free()


func _process(delta: float) -> void:
	pass

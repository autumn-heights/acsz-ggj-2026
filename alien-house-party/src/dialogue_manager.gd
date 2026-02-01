extends Node

signal pressed_go_straight
signal pressed_go_left
signal pressed_go_right

var json_data: Dictionary
var console_label: Label
var choice_container: VBoxContainer

var current_script_id: String
var current_line_id: int = -1;
var num_lines_in_current_script: int = -1;

var movement_cooldown: int = 0;
var movement_cooldown_max: float = 0.5; # in seconds

@onready var dialogue_box = %DialogueBox
@onready var npc_portrait = %NPCPortrait
@onready var nav_buttons = %NavigationButtons

const npc_textures = {
	"PLAYER_CHARACTER":
		preload("res://assets/attendees/aftonsparv.png"),
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

func get_available_dialogues_for_room(room_name: String) -> Array[String]:
	var available: Array[String] = []
	for dialogue_id in json_data.keys():
		if "rooms" in json_data[dialogue_id]:
			if (room_name in json_data[dialogue_id]["rooms"] 
			and dialogue_id not in Global.completed_dialogues):
				available.append(dialogue_id)
	return available

func try_select_dialogue(room_name: String) -> bool:
	var available: Array[String] = get_available_dialogues_for_room(room_name)
	if available.size() > 0:
		var chosen = available.pick_random()
		trigger_new_dialogue(chosen)
		return true
	return false # we're done here - notify player??

func trigger_new_dialogue(script_id: String):
	
	if script_id != null and not script_id in json_data.keys():
		assert(false) # incorrect script_id triggered!
	
	if json_data[script_id]["type"] == "talking":
		current_script_id = script_id;
		current_line_id = -1
		dialogue_box.visible = true;
		nav_buttons.visible = false;
		num_lines_in_current_script = len(json_data[script_id]["lines"])
		trigger_next_dialogue_line()
	
	elif json_data[script_id]["type"] == "choice":
		dialogue_box.visible = false;
		nav_buttons.visible = false;
		current_script_id = script_id;
		display_choice(script_id)

func trigger_next_dialogue_line():
	# if there's another line of dialogue to display, then do that
	# if there's not another line of dialogue to display, then close the dialogue box
	if current_line_id < num_lines_in_current_script -1 :
		current_line_id += 1
		display_text(json_data[current_script_id]["lines"][current_line_id]["text"])
		print(json_data[current_script_id]["lines"][current_line_id]["speaker"])
		display_npc_portrait(json_data[current_script_id]["lines"][current_line_id]["speaker"])
	elif json_data[current_script_id]["next"] != null:
		dialogue_box.visible = false;
		if "set_flag" in json_data[current_script_id]:
			print("setting flag: ", json_data[current_script_id]["set_flag"])
			Global.flags.append(json_data[current_script_id]["set_flag"])
		
		if "update_stats" in json_data[current_script_id]:
			if "stigma" in json_data[current_script_id]["update_stats"]:
				print("updating stats: ", json_data[current_script_id]["update_stats"]["stigma"])
				Global.stigma += json_data[current_script_id]["update_stats"]["stigma"]
				
		trigger_new_dialogue(json_data[current_script_id]["next"])
	else:
		dialogue_box.visible = false;
		nav_buttons.visible = true;
		Global.completed_dialogues.append(current_script_id)

func _on_advance_dialogue():
	# FUNCTION THAT GETS TRIGGERED WHEN THE PLAYER ADVANCES THE DIALOGUE BOX
	if dialogue_box.visible:
		trigger_next_dialogue_line()


func display_text(text: String):
	dialogue_box.set_new_text(text);
	
func display_npc_portrait(npc_texture_key: String):
	if npc_texture_key in npc_textures.keys():
		npc_portrait.visible = true
		npc_portrait.texture = npc_textures[npc_texture_key]
	else:
		npc_portrait.visible = false

func display_choice(script_id):
	var data = json_data[script_id]
	for child in choice_container.get_children():
		child.queue_free()
	
	for i in range(data["choices"].size()):
		var choice = data["choices"][i]
		var button: Button = Button.new()
		var chance_percent: int = int(choice["check"] * 100)
		
		var has_required_flags: bool = true
		if "required_flags" in choice:
			for flag in choice["required_flags"]:
				if not Global.has_flag(flag):
					has_required_flags = false
		
		if not has_required_flags:
			button.text = "[LOCKED] " + choice["text"]
			button.disabled = true
		else:		
			button.text = "[CHANCE: " + str(chance_percent) + "%] " + choice["text"]
			button.pressed.connect(_on_choice_pressed.bind(choice))

		choice_container.add_child(button)

func _ready():
	choice_container = VBoxContainer.new()
	choice_container.position = Vector2(10, 400)
	add_child(choice_container)
	
	load_json_file("res://script.json")
	
	dialogue_box.dialogue_advance.connect(_on_advance_dialogue)


func _on_choice_pressed(choice_data):
	#clear buttons
	for child in choice_container.get_children():
		child.queue_free()
	var roll: float = randf()
	var passed = roll < choice_data["check"]
	var next_dialogue = choice_data["pass"] if passed else choice_data["fail"]
	trigger_new_dialogue(next_dialogue)


func _process(delta: float) -> void:
	movement_cooldown -= delta;
	if Input.is_action_just_pressed("up"):
		_try_send_movement_signal(pressed_go_straight)
	elif Input.is_action_just_pressed("left"):
		_try_send_movement_signal(pressed_go_left)
	elif Input.is_action_just_pressed("right"):
		_try_send_movement_signal(pressed_go_right)
	
	pass


func _try_send_movement_signal(my_signal):
	if movement_cooldown <= 0 and nav_buttons.visible:
		my_signal.emit()
		movement_cooldown = movement_cooldown_max
		print(my_signal)

func _on_debug_convo_button_pressed() -> void:
	trigger_new_dialogue("dialogue_1");

func _on_go_left_button_pressed() -> void:
	_try_send_movement_signal(pressed_go_left)

func _on_go_straight_button_pressed() -> void:
	_try_send_movement_signal(pressed_go_straight)

func _on_go_right_button_pressed() -> void:
	_try_send_movement_signal(pressed_go_right)

extends Control

@onready var main_menu = %MainMenu
@onready var game_2d_ui = %Game2dUi

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	game_2d_ui.visible = false;
	main_menu.visible = true;
	
	main_menu.start_the_game.connect(_on_start_the_game)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_start_the_game():
	
	game_2d_ui.visible = true;
	main_menu.visible = false;
	game_2d_ui.trigger_new_dialogue("dialogue_foyer_intro")

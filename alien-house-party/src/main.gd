extends Control

@onready var main_menu = %MainMenu
@onready var game_2d_ui = %Game2dUi
@onready var state_manager= $GamestateManager
@onready var map2d = $GamestateManager/Layers2D
@onready var map3d = $GamestateManager/Map3d
@onready var musicPlayer = $MusicStream
@onready var player_controller = $"2DNavigation/PlayerCharacter/2DNavigator"
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	game_2d_ui.visible = false;
	main_menu.visible = true;
	state_manager.player_controller = player_controller
	main_menu.start_the_game.connect(_on_start_the_game)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_start_the_game():
	
	game_2d_ui.visible = true;
	main_menu.visible = false;
	map3d.digest_tiles()
	musicPlayer.play()
	game_2d_ui.trigger_new_dialogue("dialogue_foyer_intro")


func _on_player_character_random_encountered() -> void:
	print("RANDOM ENCOUNTER RAAAAAGH")
	#PROBABLY PUT A SIGNAL HERE TO TELL 2DNAVIGATOR/PLAYERCHARACTER IF THEY CAN MOVE
	game_2d_ui.trigger_new_dialogue("dialogue_foyer_intro")

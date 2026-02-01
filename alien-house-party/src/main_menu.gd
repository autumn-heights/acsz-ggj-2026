extends Control

signal start_the_game

var times_knocked = 0;
var knocks_required = 3;

@onready var doorbellSound = $AlienDoorbell
@onready var knockSound = $AlienKnockogg

func _on_knock_button_pressed():
	# todo: play a sound effect
	times_knocked += 1;
	knockSound.play()
	if times_knocked >= knocks_required:
		start_the_game.emit();


func _on_doorbell_button_pressed():
	# todo: play a sound effect
	times_knocked += 1;
	doorbellSound.play()
	if times_knocked >= knocks_required:
		start_the_game.emit();
	

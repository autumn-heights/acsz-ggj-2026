extends Node

# flag array
var flags: Array[String] = []
# e.g. ["has_cigarette", "can_talk_to_xyz"]

# stats
var stigma: int = 0
var intox: int = 0
var high: int = 0

var game_script: Dictionary

func has_flag(flag: String) -> bool:
	if flags.has(flag):
		return true
	return false

func get_stigma_stat() -> int:
	return stigma
	
func get_intox_stat() -> int:
	return intox

func get_high_stat() -> int:
	return high


func _ready() -> void:
	pass

func _process(delta: float) -> void:
	pass

extends GridMap

var tiledict = {
	Vector2i(0,0): ""
}

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _from2D(pos):
	for t_pos in tiledict.keys():
		if t_pos == pos:
			return tiledict[pos]
	printerr("failed to find /n", pos, " /n in dict: /n", tiledict)
	return 

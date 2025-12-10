extends Label

var inputs: Array

func _ready() -> void:
	inputs = [1, 2, 3]
	

func _process(delta: float) -> void:
	if Input.is_anything_pressed() and not (Input.is_action_just_pressed("pause")):
		check_array()
		
func check_array():
	if inputs.has(4):
		text = "value was found!"
	else:
		text = "value was not found..."

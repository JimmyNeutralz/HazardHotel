extends Node3D

var state
@onready var Up = $Up
@onready var Down = $Down
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	state = "up"
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if(state == "up"):
		Up.visible = true
		Down.visible = false
	if(state == "down"):
		Up.visible = false
		Down.visible = true
	toggle_curtain()

func toggle_curtain():
	if Input.is_action_pressed("toggle_curtain"):
		state = "down"
	else:
		state = "up"

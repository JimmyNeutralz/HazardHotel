extends Node3D

var active = false
@onready var UI = $VentUI
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	_AirflowOn()

func _AirflowOn():
	if Input.is_action_pressed("activate_vent"):
		UI.visible = false
		active = true
	
func _AirflowOff():
	active = false

extends Area3D

#@onready var player = load("res://Scenes/3d_player.tscn")
@onready var player = $"../3dPlayer"
@onready var puddle = load("res://Scripts/death_puddle_3d.gd")

var electrified = true


func _process(delta):
	if (Input.is_action_just_pressed("Disable 3D Puddle Electricity")):
		electrified = false
	elif (Input.is_action_just_pressed("Enable 3D Puddle Electricity")):
		electrified = true
		

func _on_body_entered(body: Node3D) -> void:
	print("Func reached")
	if (electrified):
		print("If reached")
		player.stop_moving()

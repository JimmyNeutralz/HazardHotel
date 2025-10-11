extends Area3D

#@onready var player = load("res://Scenes/3d_player.tscn")
@onready var player = $"../3dPlayer"
@onready var puddle = $"../DeathPuddle3d"

var electrified = true


func _process(delta):
	#If input statements to enable and disable the puddle's electricity along with code to allow or 
	#prevent the player from moving to the right if the puddle is safe or not respecively
	if (Input.is_action_just_pressed("Disable 3D Puddle Electricity")):
		electrified = false
		player.stop_moving(electrified)
		puddle.change_puddle_status(electrified)
	elif (Input.is_action_just_pressed("Enable 3D Puddle Electricity")):
		electrified = true
		puddle.change_puddle_status(electrified)
		puddle.determine_status()
		

#Reacts upon the player hitting the separate colider to determine if they can walk past or not
func _on_body_entered(body: Node3D) -> void:
	print("Func reached")
	player.stop_moving(electrified)

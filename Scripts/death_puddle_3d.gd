extends Area3D
@onready var player = load("res://Scenes/3d_player.tscn")
@onready var collideshape = get_node("CollisionShape3D")

var coliding = false
var unsafe = true

func change_puddle_status(electrified):
	unsafe = electrified

func _on_body_entered(body: Node3D) -> void:
	print("Body entered")
	coliding = true
	determine_status()
	
func _on_body_exited(body: Node3D) -> void:
	coliding = false
	
func determine_status():
	if (coliding && unsafe):
		print("If met")
		player.die()

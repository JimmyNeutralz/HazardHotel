extends Area3D

#@onready var player = load("res://Scenes/3d_player.tscn")
@onready var player = $"../3dPlayer"
@onready var puddle = load("res://Scripts/death_puddle_3d.gd")

var unsafe = true
var coliding = true

func _on_body_entered(body: Node3D) -> void:
	print("Func reached")
	player.stop_moving(unsafe)

#func _on_body_entered(body: CharacterBody3D) -> void:
	#player.die()
	#print("Body entered")
	#coliding = true
	#determine_status()

func determine_status():
	if (coliding && unsafe):
		print("If met")
		player.die()

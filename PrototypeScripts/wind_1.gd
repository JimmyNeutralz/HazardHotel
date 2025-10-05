extends Area2D

var hazard_active := true

func _on_body_entered(body: Node2D) -> void:
	if hazard_active and body.name == "Player": # Replace with your player node's name
		body.hide() # Hide the player sprite
		print("You died")

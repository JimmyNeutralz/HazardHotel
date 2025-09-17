extends Area2D

func _on_body_entered(body: Node2D) -> void:
	if body is CharacterBody2D:
		get_tree().change_scene_to_file("res://Floor1_Lobby.tscn")


func _on_area_entered(area: Area2D) -> void:
	pass # Replace with function body.

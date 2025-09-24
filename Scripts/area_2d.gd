extends Area2D

#@export var simultaneous_scene = preload("res://Scenes/Floor1_Lobby.tscn").instantiate()

func _on_body_entered(body: Node2D) -> void:
	if body is CharacterBody2D:
		#get_node("/root/Floor1FirstRoom").hide()
		get_tree().change_scene_to_file("res://Scenes/Floor1_Lobby_After_Vaccuum.tscn")
		#get_tree().change_scene_to_file("res://Floor1_Lobby.tscn")

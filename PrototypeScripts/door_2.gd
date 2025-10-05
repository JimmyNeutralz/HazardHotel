extends Area2D


var isLocked = false
var playerHasKey = false
#@export var simultaneous_scene = preload("res://Scenes/Floor1_ElevatorRoom.tscn").instantiate()
@onready var player = load("res://Scripts/test_player.gd")

func _add_a_scene_manually():
	get_tree().change_scene_to_file("res://Scenes/Floor1_ElevatorRoom.tscn")
	
	#get_node("/root/Main").queue_free()
	#get_tree().root.add_child(simultaneous_scene)


func _on_body_entered(body: Node2D) -> void:
	#if (player._has_key() == true):
		#isLocked = false
	if (isLocked == false):
		_add_a_scene_manually()

extends Area2D


var isLocked = false
@export var simultaneous_scene = preload("res://Scenes/OutsideTestScene.tscn").instantiate()

func _add_a_scene_manually():
	get_node("/root/Main").queue_free()
	get_tree().root.add_child(simultaneous_scene)


func _on_body_entered(body: Node2D) -> void:
	if (isLocked == false):
		_add_a_scene_manually()

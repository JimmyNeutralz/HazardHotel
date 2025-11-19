extends Node3D

#@onready var roomMark = $Area3D/LargeRoomCamera
#@onready var charMark = $CharacterBody3D/CameraMark
#@onready var camera = $CharacterBody3D/CameraMark/CharacterCamera
@onready var startPos = self.global_position

func _process(delta: float) -> void:
	self.current = true


func camera_transition(endpoint: Vector3):
	var tween = get_tree().create_tween()
	tween.tween_property(self, "global_position", endpoint, 3.0)
	tween.kill()


func _on_area_3d_body_entered(body: Node3D) -> void:
	print("Cam area entered!")
	camera_transition(Vector3.ZERO)


func _on_area_3d_body_exited(body: Node3D) -> void:
	print("Cam area exited!")
	camera_transition(startPos)

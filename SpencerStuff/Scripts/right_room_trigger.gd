extends Area3D

#node paths
@onready var camera = $"../../Cameras/Camera"
@onready var right_pos = $"../../Cameras/RightCamPos"

#when player enters doorway, pan to right camera pos
func _on_body_entered(body: Node3D) -> void:
	if body.name == "Player":
		print("Player entered right room")
		camera.pan_to(right_pos.global_position)

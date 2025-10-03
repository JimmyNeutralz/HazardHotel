extends Area3D

#node paths
@onready var camera = $"../../Cameras/Camera"
@onready var left_pos = $"../../Cameras/LeftCamPos"

#when player enters doorway, pan to left camera pos
func _on_body_entered(body: Node3D) -> void:
	if body.name == "Player":
		print("Player entered left room")
		camera.pan_to(left_pos.global_position) 

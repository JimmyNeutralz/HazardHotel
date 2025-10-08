extends Area3D

#node paths
@onready var camera = $"../../Cameras/Camera"
@onready var main_pos = $"../../Cameras/MainCamPos"

#when player enters doorway, pan to main camera pos
func _on_body_entered(body: Node3D) -> void:
	if body.name == "Player":
		print("Player entered main room")
		camera.pan_to(main_pos.global_position)

extends Area3D

@onready var camera1 = $"../../Cameras/Camera1"
@onready var camera2 = $"../../Cameras/Camera2"
@onready var camera3 = $"../../Cameras/Camera3"

func _on_body_entered(body: Node3D) -> void:
	if body.name == "Player":
		print("Player entered left room")
		camera1.current = false
		camera2.current = true
		camera3.current = false

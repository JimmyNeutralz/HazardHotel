extends Area3D

#Node paths
@onready var camera1 = $"../../Cameras/Camera1"
@onready var camera2 = $"../../Cameras/Camera2"
@onready var camera3 = $"../../Cameras/Camera3"

#Detect player and set proper camera
func _on_body_entered(body: Node3D) -> void:
	if body.name == "Player":
		print("Player in main room")
		camera1.current = true
		camera2.current = false
		camera3.current = false

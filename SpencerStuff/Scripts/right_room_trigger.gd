extends Area3D

#Node Paths
@onready var camera1 = $"../../Cameras/Camera1"
@onready var camera2 = $"../../Cameras/Camera2"
@onready var camera3 = $"../../Cameras/Camera3"

#Detect player, set proper camera
func _on_body_entered(body: Node3D) -> void:
	if body.name == "Player":
		print("Player entered right room")
		camera1.current = false
		camera2.current = false
		camera3.current = true

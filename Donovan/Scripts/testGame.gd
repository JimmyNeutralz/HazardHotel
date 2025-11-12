extends Node3D

@onready var roomCam = $Area3D/RoomCamera
@onready var charCam = $CharacterBody3D/CharacterCamera
@onready var transCam = $TransitionCamera

var charMain = true

func _process(delta: float) -> void:
	if(charMain == true):
		charCam.current = true
		pass


func _on_area_3d_body_entered(body: Node3D) -> void:
	print("Cam Area Entered!")
	#transCam.position = charCam.position
	#transCam.current = true
	#camera_transition(charCam, "position", roomCam.position, 2.0)
	
	roomCam.current = true
	#transCam.current = false
	
	#roomCam.current = true
	charMain = false


func _on_area_3d_body_exited(body: Node3D) -> void:
	print("Cam Area Exited!")
	charCam.current = true
	#camera_transition(roomCam, "position", charCam.position, 2.0)

	charMain = true
	
func camera_transition(node, property, final_value, duration):
	var tween = create_tween().set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_LINEAR)
	tween.tween_property(node, property, final_value, duration)
	node.current = true
	
	

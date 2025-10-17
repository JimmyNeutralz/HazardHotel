extends Node3D

@onready var roomCam = $BigRoomTriggers/MiddleRoomTrigger/LargeRoomCamera/RoomCamera
@onready var charCam = $CharacterBody3D/CameraMark/CharacterCamera
@onready var transCam = $TransitionCamera
@onready var player = $CharacterBody3D
var acceptableDistance = Vector3(0.1, 0.1, 0.1)
var transitionTime = 1.0
var charMain = true
var backToPlayer = true
var time = 0.0

# Sets camera on character to be active and sets the transition camera to 
# its position continuously
func _process(delta: float) -> void:
	if(charMain == true):
		charCam.current = true
		transCam.global_position = charCam.global_position
	


# Transitions the player camera to the static room camera position when
# middle trigger is entered
func _on_area_3d_body_entered(body: Node3D) -> void:
	print("Cam Area Entered!")
	charMain = false
	player.canMove = false
	
	charCam.current = false
	transCam.current = true
	var tween = create_tween()
	tween.tween_property(transCam, "global_position", roomCam.global_position, transitionTime)
	tween.parallel().tween_property(transCam, "fov", roomCam.fov, transitionTime)
	
	await tween.finished
	transCam.current = false
	roomCam.current = true
	player.canMove = true


# Transitions from room camera back to player when middle trigger entered
func _on_area_3d_body_exited(body: Node3D) -> void:
	print("Cam Area Exited!")
	roomCam.current = false
	transCam.current = true
	transCam.position = transCam.position.lerp(charCam.position, time)
	player.canMove = false
	
	var tween = create_tween()
	tween.set_process_mode(Tween.TWEEN_PROCESS_PHYSICS)
	tween.tween_property(transCam, "global_position", charCam.global_position, transitionTime)
	tween.parallel().tween_property(transCam, "fov", charCam.fov, transitionTime)
	
	await tween.finished
	transCam.current = false
	charCam.current = true
	player.canMove = true
	
func _lerp_to_player(body: Node3D) -> void:
	transCam.position = transCam.position.lerp(charCam.position, time)
	

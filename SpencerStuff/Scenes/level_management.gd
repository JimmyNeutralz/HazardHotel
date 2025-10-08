extends Node3D

#Node paths
@onready var left_key = $LeftWall/LeftKey
@onready var right_key = $RightWall/RightKey
@onready var elevator_lock = $Elevator/ElevatorLock

#Key states
var has_left_key: bool = false
var has_right_key: bool = false


#Left key area trigger
func _on_left_trigger_body_entered(body: Node3D) -> void:
	if body.name == "Player":
		if not has_left_key:
			has_left_key = true
			left_key.visible = false
			print("Left key obtained")
			_check_keys()


#Right key area trigger
func _on_right_trigger_body_entered(body: Node3D) -> void:
	if body.name == "Player":
		if not has_right_key:
			has_right_key = true
			right_key.visible = false
			print("Right key obtained")
			_check_keys()

#Check for player having both keys, open elevator
func _check_keys() -> void:
	if has_left_key and has_right_key:
		elevator_lock.visible = false
		print("Elevator unlocked. Floor completed!")

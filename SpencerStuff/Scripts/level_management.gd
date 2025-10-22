extends Node3D

#Node paths
@onready var left_key = $LeftWall/LeftKey
@onready var right_key = $RightWall/RightKey
@onready var elevator_lock = $Elevator/ElevatorLock
@onready var generator = $Generator
@onready var fade_in_static = $Cameras/Camera/FadeInView

@export var next_scene_path := "res://Donovan/MODIFIEDAlphaV4.tscn"

#Key states
var has_left_key: bool = false
var has_right_key: bool = false

func _ready():
	fade_in_static._fade_static_out()


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


#Check for player in front of elevator and both keys found, transition
#to next level
func _on_area_3d_body_entered(body: Node3D) -> void:
	if generator.activated:
		fade_in_static._exit_scene(next_scene_path)
		#fade_in_static._fade_static_in()
		#get_tree().change_scene_to_file(next_scene_path)

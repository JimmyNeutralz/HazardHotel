extends Area2D

@export var Player: CharacterBody2D
var isEletrified = true
var isOpened = false


func _process(delta):
	
	# Test for custom input actions
	if (Input.is_action_just_pressed("Activate Eletric Door") and !isEletrified):
		print("Door electrified")
		isEletrified = true
	elif (Input.is_action_just_pressed("Deactivate Eletric Door") and isEletrified):
		print("Door safe")
		isEletrified = false
	elif (Input.is_action_just_pressed("Open Eletric Door") and !isOpened):
		print("Door opened")
		isOpened = true
		Player._move_to_right_door(delta)
	elif (Input.is_action_just_pressed("Close Eletric Door") and isOpened):
		print("Door closed")
		isOpened = false
		Player._move_to_right_door(delta)

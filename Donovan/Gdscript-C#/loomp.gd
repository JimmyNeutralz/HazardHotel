extends Node

var isPressed = false

func _input(event):
	if event.is_action_pressed("right"):
		isPressed = true
	elif event.is_action_pressed("left"):
		isPressed = false

extends Area2D

var isConnected = false


func _process(delta):
	
	# Test for custom input actions
	if (Input.is_action_just_pressed("Connect Green Wire") and !isConnected):
		$AnimatedSprite2D.modulate = Color(0, 1, 0)
		print("Green Wire Connected")
		isConnected = true
	elif (Input.is_action_just_pressed("Disconnect Green Wire") and isConnected):
		$AnimatedSprite2D.modulate = Color(1, 1, 1)
		print("Green Wire Disconnected")
		isConnected = false

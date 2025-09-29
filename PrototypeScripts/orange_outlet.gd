extends Area2D

var isConnected = true


func _process(delta):
	
	# Test for custom input actions
	if (Input.is_action_just_pressed("Connect Orange Wire") and !isConnected):
		#$AnimatedSprite2D.modulate = Color(0, 0, 1)
		print("Orange Wire Connected")
		isConnected = true
	elif (Input.is_action_just_pressed("Disconnect Orange Wire") and isConnected):
		#$AnimatedSprite2D.modulate = Color(1, 1, 1)
		print("Orange Wire Disconnected")
		isConnected = false

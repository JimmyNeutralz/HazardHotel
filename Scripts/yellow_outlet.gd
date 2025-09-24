extends Area2D

var isConnected = false


func _process(delta):
	
	# Test for custom input actions
	if (Input.is_action_just_pressed("Connect Yellow Wire") and !isConnected):
		$Sprite2D.modulate = Color(0, 0, 0)
		print("Yellow Wire Connected")
		isConnected = true
	elif (Input.is_action_just_pressed("Disconnect Yellow Wire") and isConnected):
		$Sprite2D.modulate = Color(1, 1, 1)
		print("Yellow Wire Disconnected")
		isConnected = false

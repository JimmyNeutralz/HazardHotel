extends Area2D


var isConnected = false


func _process(delta):
	
	# Test for custom input actions
	if (Input.is_action_just_pressed("Connect Purple Wire") and !isConnected):
		$AnimatedSprite2D.modulate = Color(0, 0, 1)
		print("Purple Wire Connected")
		isConnected = true
		
		
	elif (Input.is_action_just_pressed("Disconnect Purple Wire") and isConnected):
		$AnimatedSprite2D.modulate = Color(1, 1, 1)
		print("Purple Wire Disconnected")
		isConnected = false

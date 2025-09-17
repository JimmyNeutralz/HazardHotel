extends Area2D


var isConnected = false
@onready var darkBox = $Dark

func _process(delta):
	
	
	# Test for custom input actions
	if (Input.is_action_just_pressed("Connect Purple Wire") and !isConnected):
		$AnimatedSprite2D.modulate = Color(0, 0, 1)
		print("Purple Wire Connected")
		isConnected = true
		darkBox.visible = false
		darkBox.isDark = false
		
		
	elif (Input.is_action_just_pressed("Disconnect Purple Wire") and isConnected):
		$AnimatedSprite2D.modulate = Color(1, 1, 1)
		print("Purple Wire Disconnected")
		isConnected = false
		darkBox.visible = true
		darkBox.isDark = true

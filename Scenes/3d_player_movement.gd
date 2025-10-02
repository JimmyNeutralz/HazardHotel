extends Area3D
@export var speed = 2
@onready var hitBox = $CollisionShape3D
@onready var player = load("res://Scenes/3d_player.tscn")
var location: Vector3
var direction: Vector3

var leftKeyPressed = false
var rightKeyPressed = false
var centerKeyPressed = false

func _process(delta):
	if(Input.is_action_just_pressed("Left 3D Spot") and !leftKeyPressed):
		#print("If met")
		leftKeyPressed = true
		rightKeyPressed = false
		centerKeyPressed = false
		direction = Vector3(-1.7, 0, 0)
	elif(Input.is_action_just_pressed("Right 3D Spot") and !rightKeyPressed):
		#print("If met")
		rightKeyPressed = true
		leftKeyPressed = false
		centerKeyPressed = false
		direction = Vector3(1.7, 0, 0)
	elif(Input.is_action_just_pressed("Center 3D Spot") and !centerKeyPressed):
		#print("If met")
		centerKeyPressed = true
		leftKeyPressed = false
		rightKeyPressed = false
		#direction = Vector3(-global_position.x, 0, 0)
		
		if (global_position.x >= 0):
			direction = Vector3(-1.7, 0, 0)
			print(direction)
		elif (global_position.x <= 0):
			direction = Vector3(1.7, 0, 0)
			print(direction)
	
	if (global_position.x < -1.7 ):
		leftKeyPressed = false
	elif (global_position.x > 1.7):
		rightKeyPressed = false
	elif (global_position.x > -0.01 and global_position.x < 0.01 and centerKeyPressed):
		centerKeyPressed = false
	if (leftKeyPressed or rightKeyPressed or centerKeyPressed):
		#print("If met")
		global_position += direction * delta * speed
	#if (Input.is_action_just_pressed("Left 3D Spot") and position != Vector3(-1.7,0.35,0)):
		#move left
		#location = Vector3(-1.7,0.35,0)
		
	#elif (Input.is_action_just_pressed("Right 3D Spot") and position != Vector3(1.7,0.35,0)):
		#move right
		#location = Vector3(1.7,0.35,0)
		
	

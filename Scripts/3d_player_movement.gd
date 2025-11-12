extends CharacterBody3D
@export var speed = 2
@onready var hitBox = $CollisionShape3D
@onready var player = $"../3dPlayer"
var location: Vector3

#The destination determined by what key the player selects
var direction: Vector3

var stopPoint = 2.66

#Bool values used to prevent movement beyond the destination or to keep the player moving
var leftKeyPressed = false
var rightKeyPressed = false
var centerKeyPressed = false
#Bool made to prevent the player from walking into a visible hazard
var preventMoving = false

func _process(delta):
	#If the A key is pressed, set desination to 1.7 to the left
	if(Input.is_action_just_pressed("Left 3D Spot") and !leftKeyPressed):
		#print("If met")
		leftKeyPressed = true
		rightKeyPressed = false
		centerKeyPressed = false
		preventMoving = false
		direction = Vector3(-stopPoint, 0, 0)
	#If the D key is pressed and no hazard is ahead, set desination to 1.7 to the right
	elif(Input.is_action_just_pressed("Right 3D Spot") and !rightKeyPressed and !preventMoving):
		#print("If met")
		rightKeyPressed = true
		leftKeyPressed = false
		centerKeyPressed = false
		direction = Vector3(stopPoint, 0, 0)
	#If the S key is pressed, set desination to 1.7 to the right
	elif(Input.is_action_just_pressed("Center 3D Spot") and !centerKeyPressed):
		#print("If met")
		centerKeyPressed = true
		leftKeyPressed = false
		rightKeyPressed = false
		preventMoving = false
		#direction = Vector3(-global_position.x, 0, 0)
		
		#Sets direction appropreately so that the speed to the center is consistent with left and right travel
		if (global_position.x >= 0):
			direction = Vector3(-stopPoint, 0, 0)
			#print(direction)
		elif (global_position.x <= 0):
			direction = Vector3(stopPoint, 0, 0)
			#print(direction)
	
	#Stops the player moving if they reach either side or the center by setting the appropreate bool value to false
	if (global_position.x < -stopPoint):
		leftKeyPressed = false
	elif (global_position.x > stopPoint):
		rightKeyPressed = false
	elif (global_position.x > -0.01 and global_position.x < 0.01 and centerKeyPressed):
		centerKeyPressed = false
	#If any of the bool values that determine movement are true, gradually move to the destination by updating global position
	if (leftKeyPressed or rightKeyPressed or centerKeyPressed):
		#print("If met")
		global_position += direction * delta * speed
	#if (Input.is_action_just_pressed("Left 3D Spot") and position != Vector3(-1.7,0.35,0)):
		#move left
		#location = Vector3(-1.7,0.35,0)
		
	#elif (Input.is_action_just_pressed("Right 3D Spot") and position != Vector3(1.7,0.35,0)):
		#move right
		#location = Vector3(1.7,0.35,0)
		
	
#Function that prevents moving past a visibly electrified death puddle.
func stop_moving(electrified):
	if (electrified):
		leftKeyPressed = false
		rightKeyPressed = false
		centerKeyPressed = false
		print("That was a close one!")
		preventMoving = true
	else:
		preventMoving = false

extends CharacterBody3D
@export var speed = 2

#Variables containing objects to access functions into other scripts
@onready var hitBox = $CollisionShape3D
@onready var player = $"../3dPlayer"
@onready var puddle = $"../DeathPuddle3d"
@onready var door = $"../3dElectricDoor"
@onready var fuseBoxUi = $"../Camera3D/FuseBoxUi"
@onready var text = $"../Camera3D/RichTextLabel"
#@export var text: RichTextLabel
@onready var elevator = $"../Elevator"

var location: Vector3

#The destination determined by what key the player selects
var direction: Vector3

#Variable used to determine where the user should stop for the auto movement to the left and right
var stopPoint = 2.66

#Bool values used to prevent movement beyond the destination or to keep the player moving
var leftKeyPressed = false
var rightKeyPressed = false
var centerKeyPressed = false
var moving = false
#Bool made to prevent the player from walking into a visible hazard
var preventMoving = false

var preventLeftMovement = false
var preventRightMovement = false

#Bool value to determine if the player is standing in the electrified puddle
var inDanger = false

var destinationBlocked = false
var lastLocation

func _process(delta):
	if (!fuseBoxUi.interactingWith):
		#If the A key is pressed, set desination to 1.7 to the left
		if(Input.is_action_just_pressed("Left 3D Spot") and !leftKeyPressed and !preventLeftMovement):
			#print("If met")
			leftKeyPressed = true
			rightKeyPressed = false
			centerKeyPressed = false
			preventMoving = false
			preventRightMovement = false
			direction = Vector3(-stopPoint, 0, 0)
			$Sprite3D.flip_h = true
		#If the D key is pressed and no hazard is ahead, set desination to 1.7 to the right
		elif(Input.is_action_just_pressed("Right 3D Spot") and !rightKeyPressed and !preventMoving and !preventRightMovement):
			#print("If met")
			rightKeyPressed = true
			leftKeyPressed = false
			centerKeyPressed = false
			preventLeftMovement = false
			direction = Vector3(stopPoint, 0, 0)
			$Sprite3D.flip_h = false
		#If the S key is pressed, set desination to 1.7 to the right
		elif(Input.is_action_just_pressed("Center 3D Spot") and !centerKeyPressed and !preventRightMovement):
			#print("If met")
			centerKeyPressed = true
			leftKeyPressed = false
			rightKeyPressed = false
			preventMoving = false
			preventLeftMovement = false
			#direction = Vector3(-global_position.x, 0, 0)
			
			#Sets direction appropreately so that the speed to the center is consistent with left and right travel
			if (global_position.x >= 0):
				direction = Vector3(-stopPoint, 0, 0)
				$Sprite3D.flip_h = true
				#print(direction)
			elif (global_position.x <= 0):
				direction = Vector3(stopPoint, 0, 0)
				$Sprite3D.flip_h = false
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
			
#If this function is triggered, the player dies
func death():
	#Disables movement
	preventLeftMovement = true
	preventRightMovement = true
	reached_destination()
	print ("YOU DIED!")
	
	#Line of code found at GDScript.com underneath solutions
	await get_tree().create_timer(2.0).timeout
	
	#Sets the player back to the elevator entrance after respawning
	global_position.x = elevator.global_position.x
	preventLeftMovement = false
	preventRightMovement = false

#Function that prevents moving past a visibly electrified death puddle.
func stop_moving(electrified):
	if (electrified):
		text.avoided_puddle()
		reached_destination()
		print("That was a close one!")
		preventMoving = true
	else:
		preventMoving = false
#Function that prevents the player from moving a certain direction 
# depending on what's blocking a given direction
func blocked_path(position, pathBlocked):
	if (pathBlocked):
		#Separate bool statements from reached_destination since 
		leftKeyPressed = false
		rightKeyPressed = false
		centerKeyPressed = false
		moving = false
		#Disables certain movement directions depending on where the character is standing
		if (global_position.x < position.x):
			preventRightMovement = true
			preventLeftMovement = false
		elif (global_position.y > position.y):
			preventLeftMovement = true
			preventRightMovement = false
	else:
		preventLeftMovement = false
		preventRightMovement = false
#Function to automatically move left upon unlocking the electric gate
func moveLeft():
	leftKeyPressed = true
	rightKeyPressed = false
	centerKeyPressed = false
	direction = Vector3(-stopPoint, 0, 0)
	$Sprite3D.flip_h = true
	
#Function that moves new guy to a given location
func move_to(location):
	centerKeyPressed = false
	preventMoving = false
	preventLeftMovement = false
	preventRightMovement = false
	
	moving = true
	destinationBlocked = false
	
	lastLocation = location
	if (global_position.x >= location):
			direction = Vector3(-stopPoint, 0, 0)
			$Sprite3D.flip_h = true
			leftKeyPressed = true
			rightKeyPressed = false
			#print(direction)
	elif (global_position.x <= location):
			direction = Vector3(stopPoint, 0, 0)
			rightKeyPressed = true
			leftKeyPressed = false
			$Sprite3D.flip_h = false

#Code to set all movement functions to false upon arriving at a specific spot
func reached_destination():
	leftKeyPressed = false
	rightKeyPressed = false
	centerKeyPressed = false
	moving = false
	
	destinationBlocked = false


#Checks if the door is unlocked along if the door is safe to determine final result
func _on_3d_electric_door_body_entered(body: Node3D) -> void:
	if(!door.opened):
		door.determine_result()

#Function that opens up the UI used to complete the fuse box
func _on_fuse_box_body_entered(body: Node3D) -> void:
	if (moving and !fuseBoxUi.complete and (fuseBoxUi.fusesGathered >= 1)):
		moving = false
		player.reached_destination()
		fuseBoxUi.toggle_visibility(true)
		in_menu()
	elif(moving and fuseBoxUi.complete):
		moving = false
		player.reached_destination()
		text.completed_fusebox()
	elif (moving and fuseBoxUi.fusesGathered < 1):
		moving = false
		player.reached_destination()
		text.missing_fuses()

#Prevents movement while the player in the fuse menu
func in_menu():
	preventMoving = true
	preventLeftMovement = true
	preventRightMovement = true

#Reneables movement after the user successfully completes the fuse puzzle
func out_of_menu():
	preventMoving = false
	preventLeftMovement = false
	preventRightMovement = false

func move_to_blocked_location():
	move_to(lastLocation)

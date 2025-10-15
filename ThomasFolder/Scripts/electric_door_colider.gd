extends Area3D
#Variable used to reference functions back to the player
@onready var player = $"../3dPlayer"
#Bool values that determine if the door is unlocked or electrified
var unlocked = false
var isEletrified = true

#Bool value that determines if the new guy opened the gate or not
var opened = false

func _process(delta):
	if (!opened):
		# Input if statements to change if the door is unlocked or electrified
		if (Input.is_action_just_pressed("Activate Eletric Door") and !isEletrified):
			print("Door electrified")
			isEletrified = true
		elif (Input.is_action_just_pressed("Deactivate Eletric Door") and isEletrified):
			print("Door safe")
			isEletrified = false
		elif (Input.is_action_just_pressed("Open Eletric Door") and !unlocked):
			print("Door opened")
			player.moveLeft()
			unlocked = true
		elif (Input.is_action_just_pressed("Close Eletric Door") and unlocked):
			print("Door closed")
			unlocked = false

#Function that determines if player can successfully pass through the gate or not
func determine_result():
	if (!unlocked && !isEletrified):
		player.blocked_path(global_position, unlocked)
		print("Seems like the door is locked...")
	elif (isEletrified):
		player.death()
	else:
		print("Door successfully passed!")
		opened = true

extends Area3D

@onready var player = $"../3dPlayer"
var unlocked = false
var isEletrified = true

func _process(delta):
	
	# Test for custom input actions
	if (Input.is_action_just_pressed("Activate Eletric Door") and !isEletrified):
		print("Door electrified")
		isEletrified = true
	elif (Input.is_action_just_pressed("Deactivate Eletric Door") and isEletrified):
		print("Door safe")
		isEletrified = false
	elif (Input.is_action_just_pressed("Open Eletric Door") and !unlocked):
		print("Door opened")
		unlocked = true
	elif (Input.is_action_just_pressed("Close Eletric Door") and unlocked):
		print("Door closed")
		unlocked = false

func determine_result():
	if (!unlocked && !isEletrified):
		player.blocked_path(global_position, unlocked)
		print("Seems like the door is locked...")
	elif (!unlocked && isEletrified):
		player.death()
	else:
		print("Door successfully passed!")

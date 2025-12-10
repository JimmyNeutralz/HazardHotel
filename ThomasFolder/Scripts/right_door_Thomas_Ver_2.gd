extends Node3D

@export var lock_node_path: NodePath
@onready var lock_script = get_node(lock_node_path)
@onready var player = $"../Player"
@onready var location1 = $Location1
@onready var location2 = $Location2

var locked: bool = true
var door_anim: AnimationPlayer

@onready var blocker = $Door/RightArea

func _ready():
	#Find door animation player under tree
	door_anim = find_animation_player(self)
	if door_anim and door_anim.has_animation("Take 001"):
		door_anim.seek(0.0, true)

func _process(_delta):
	#Global.check_array(2, 5) or 
	if locked and (Global.check_array(2, 5)) and name == "LeftDoor":
		unlock_door()
		move_past_right_door()
		
		#Global.check_array(2, 5) or 
	if locked and (Global.check_array(2, 5)) and name == "RightDoor":
		unlock_door()
		move_past_right_door()
		
	if Input.is_action_just_released("deactivate_puddle"):
		pass
	
	## Test for resource budgeting
	#if (Global.check_array(1, 0)):
		#pass
	#else:
		#pass

func move_past_right_door():
	#print(blocker.global_position.x)
	if (player.global_position.x < 1.5):
		blocker.global_position.x = 0
		player.move_through_right_door(location1, 1)
		await get_tree().create_timer(1.5).timeout
		blocker.global_position.x = 999
		#player.move_to_adjacent_room(1)
	elif (player.global_position.x > 1.5):
		blocker.global_position.x = 1.5
		player.move_through_right_door(location1, -1)
		await get_tree().create_timer(1.5).timeout
		blocker.global_position.x = 999
		#player.move_to_adjacent_room(-1)
		await get_tree().create_timer(1).timeout
		#player.move_to_room_center()

func unlock_door():
	locked = false
	
	#Play lock animation first
	if lock_script:
		await lock_script.play_lock_animation()

	player.standing_player_interact()
	#Then play door
	if door_anim and door_anim.has_animation("Take 001"):
		door_anim.play("Take 001")

	print(name + " unlocked!")
	$Door/RightDoorAudio.play()

	
	
	await get_tree().create_timer(2.0).timeout
	if (player.global_position.x > 0):
		blocker.global_position.x = 1.5
	else:
		blocker.global_position.x = 0
	door_anim.play_backwards("Take 001")
	
	await get_tree().create_timer(2.5).timeout
	await lock_script.play_backwards_lock_animation()
	locked = true

func find_animation_player(node: Node) -> AnimationPlayer:
	if node is AnimationPlayer:
		return node
	for child in node.get_children():
		var found = find_animation_player(child)
		if found:
			return found
	return null

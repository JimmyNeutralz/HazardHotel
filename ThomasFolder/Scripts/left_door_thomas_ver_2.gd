extends Node3D

@export var lock_node_path: NodePath
@onready var lock_script = get_node(lock_node_path)
@onready var player = $"../Player"

@onready var blocker = $Door/LeftArea

var locked: bool = true
var door_anim: AnimationPlayer

func _ready():
	#Find door animation player under tree
	door_anim = find_animation_player(self)
	if door_anim and door_anim.has_animation("Take 001"):
		door_anim.seek(0.0, true)

func _process(_delta):
	if locked and Input.is_action_just_pressed("unlock_left") and name == "LeftDoor":
		unlock_door()
		move_past_left_door()
	if locked and Input.is_action_just_pressed("unlock_right") and name == "RightDoor" :
		unlock_door()
		move_past_left_door()

func move_past_left_door():
	if (player.global_position.x > -1.5):
		blocker.global_position.x = 0
		player.move_to_adjacent_room(-1)
		await get_tree().create_timer(1.5).timeout
		blocker.global_position.x = -999
		player.move_to_adjacent_room(-1)
	elif (player.global_position.x < -1.5):
		blocker.global_position.x = -1.5
		player.move_to_adjacent_room(2)
		await get_tree().create_timer(1.5).timeout
		blocker.global_position.x = -999
		player.move_to_adjacent_room(2)
		await get_tree().create_timer(1).timeout
		player.move_to_room_center()

func unlock_door():
	locked = false
	
	#Play lock animation first
	if lock_script:
		await lock_script.play_lock_animation()

	#Then play door
	if door_anim and door_anim.has_animation("Take 001"):
		door_anim.play("Take 001")

	print(name + " unlocked!")
	$Door/LeftDoorAudio.play()
	
	await get_tree().create_timer(2.0).timeout
	if (player.global_position.x < 0):
		blocker.global_position.x = -1.5
	else:
		blocker.global_position.x = 0
	door_anim.play_backwards("Take 001")
	await get_tree().create_timer(door_anim.current_animation_length).timeout
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

#Spencer automove based off Thomas automove
extends CharacterBody3D

#Set speed and remember to set node path for room detectors in inspector
@export var speed: float = 3.5
@export var room_detectors_path: NodePath
var player_sprite


#Store door locations
var leftDoorLoc1
var leftDoorLoc2
var rightDoorLoc1
var rightDoorLoc2

#Declarations
var room_detectors: Node
var current_room: Node = null
var target_position: Vector3
var is_moving = false
var rooms = []
var room_order = []

#For respawning
@export var spawn_node_path = "Player/PlayerSpawnPosition"
var is_dead = false
const RESPAWN_DELAY = 2.0
var spawn_transform: Transform3D


func _ready():
	leftDoorLoc1 = get_node("../LeftDoor/Location1")
	leftDoorLoc2 = get_node("../LeftDoor/Location2")
	rightDoorLoc1 = get_node("../RightDoor/Location1")
	rightDoorLoc2 = get_node("../RightDoor/Location2")
	room_detectors = get_node(room_detectors_path)
	player_sprite = $PlayerSprite
	
	player_sprite.scale.x = 0.3
	
	if player_sprite.sprite_frames != null and player_sprite.sprite_frames.has_animation("Idle"):
		player_sprite.play("Idle")
	else:
		push_warning("Playersprite missing thing")
	
	
	#Store references to each room in order (Left, Main, Right)
	room_order = [
		room_detectors.get_node("LeftRoom"),
		room_detectors.get_node("MainRoom"),
		room_detectors.get_node("RightRoom")
	]
	
	rooms = room_order
	target_position = global_position
	
	# Get the hardcoded spawn position node
	if has_node(spawn_node_path):
		var spawn_node = get_node(spawn_node_path)
		spawn_transform = spawn_node.global_transform
	else:
		push_error("PlayerSpawnPosition node not found at: " + str(spawn_node_path))
		spawn_transform = global_transform # fallback to current pos

#Use Thomas' structure
func _physics_process(delta):
	if is_dead:
		return
	
	if is_moving:
		var direction = target_position - global_position
		if direction.length() < 0.05:
			is_moving = false
			velocity = Vector3.ZERO
		else:
			velocity = direction.normalized() * speed
		move_and_slide()
	else:
		velocity = Vector3.ZERO
		move_and_slide()

	#Input controls
	if Input.is_action_just_pressed("Center 3D Spot"): #"S"
		move_to_room_center()
	elif Input.is_action_just_pressed("Left 3D Spot"): #"A"
		move_to_adjacent_room(-1)
	elif Input.is_action_just_pressed("Right 3D Spot"): #"D"
		move_to_adjacent_room(1)
		
		
	elif Input.is_action_just_pressed("unlock_left"):
		move_through_left_door(leftDoorLoc1, 1)
	elif Input.is_action_just_pressed("unlock_right"):
		move_through_right_door(rightDoorLoc1, 1)
		
	
	elif Input.is_action_just_pressed("reverse_unlock_left"):
		move_through_left_door(leftDoorLoc2, -1)
	elif Input.is_action_just_pressed("reverse_unlock_right"):
		move_through_right_door(rightDoorLoc2, -1)

#Move to center of room 
func move_to_room_center():
	var room = get_current_room()
	if room:
		var center = room.get_node(room.name + "Center")
		target_position = Vector3(center.global_position.x, global_position.y, global_position.z)
		is_moving = true

#For moving between rooms
func move_to_adjacent_room(direction: int):
	var current = get_current_room()
	if current == null:
		return
	
	var index = room_order.find(current)
	var next_index = index + direction
	
	if next_index < 0:
		#Already at leftmost room
		var left_room = room_order[0]
		var center = left_room.get_node(left_room.name + "Center")
		target_position = Vector3(center.global_position.x - 3.0, global_position.y, global_position.z)
	elif next_index >= room_order.size():
		#Already at rightmost room
		var right_room = room_order[-1]
		var center = right_room.get_node(right_room.name + "Center")
		target_position = Vector3(center.global_position.x + 3.0, global_position.y, global_position.z)
	else:
		#Move to next room’s center
		var next_room = room_order[next_index]
		var center = next_room.get_node(next_room.name + "Center")
		target_position = Vector3(center.global_position.x, global_position.y, global_position.z)
	
	is_moving = true
	
func move_to_object(object):
	target_position.x = object.global_position.x
	
	is_moving = true
	
func move_through_left_door(object, side):
	
	if (side == 1):
		move_to_object(object)
		await get_tree().create_timer(1.5).timeout
		move_to_object(leftDoorLoc2)
		
	if (side == -1):
		move_to_object(object)
		await get_tree().create_timer(1.5).timeout
		move_to_object(leftDoorLoc1)
	
func move_through_right_door(object, side):
	if (side == 1):
		move_to_object(object)
		await get_tree().create_timer(1.5).timeout
		move_to_object(rightDoorLoc2)
		
	if (side == -1):
		move_to_object(object)
		await get_tree().create_timer(1.5).timeout
		move_to_object(rightDoorLoc1)

#For figuring out which rooms player is currently in using distance to nodes
func get_current_room():
	var closest_room = null
	var closest_dist = INF
	
	for room in rooms:
		var center = room.get_node(room.name + "Center")
		var dist = global_position.distance_to(center.global_position)
		if dist < closest_dist:
			closest_dist = dist
			closest_room = room
	
	return closest_room

#New function for handling player death
func kill_player():
	if is_dead:
		return
	is_dead = true
	print("Player died!")

	#Temporarily disable player
	set_process(false)
	set_physics_process(false)
	visible = false
	is_moving = false
	velocity = Vector3.ZERO

	#Wait before respawning
	await get_tree().create_timer(RESPAWN_DELAY).timeout
	respawn_player()

#Respawn
func respawn_player():
	#Move to PlayerSpawnPosition node’s location
	global_transform = spawn_transform
	velocity = Vector3.ZERO
	is_moving = false
	is_dead = false
	visible = true
	set_process(true)
	set_physics_process(true)
	print("Respawned!")

	#ResetCamera
	var camera = get_tree().get_first_node_in_group("MainCamera")
	if camera and camera.has_method("ResetCamera"):
		camera.ResetCamera()
	else:
		print("MainCamera not found or missing ResetCamera() function.")

#Spencer automove based off Thomas automove

extends CharacterBody3D

#Set speed and remember to set node path for room detectors in inspector
@export var speed: float = 3.5
@export var room_detectors_path: NodePath

#Generator reference for determining if level is complete
@onready var generator = $"../Generator"

#Player sprite 
#@onready var player_sprite = $PlayerSprite
var player_sprite

#Declarations
var room_detectors: Node
var current_room: Node = null
var target_position: Vector3
var is_moving = false
var rooms = []
var room_order = []
var stuck_timer: float = 0.0
const STUCK_TIME_THRESHOLD: float = 0.1  #If stuck for this long, stop moving - fine tune 

#For respawning
@export var spawn_node_path: NodePath = ^"/root/Player/PlayerSpawnPosition"
var is_dead = false
const RESPAWN_DELAY = 3.75
var spawn_transform: Transform3D

#Footstep audio
var footstep_players: Array = []
var current_footstep_index = 0
var footsteps_playing = false

func _ready():
	
	player_sprite = $PlayerSprite
	#Sprite starts facing to the left (default state)
	#player_sprite.scale.x = 0.3 #Add a negative sign in front to flip sprite to face the right
	
	# Make sure the idle animation plays by default
	if player_sprite and player_sprite.sprite_frames != null and player_sprite.sprite_frames.has_animation("Idle"):
		player_sprite.play("Idle")
		stop_footsteps()

	else:
		push_warning("PlayerSprite missing 'Idle' animation or SpriteFrames resource")
	
	room_detectors = get_node(room_detectors_path)
	
	#Store references to each room 
	room_order = [
		room_detectors.get_node("LeftRoom"),
		room_detectors.get_node("MainRoom"),
		room_detectors.get_node("RightRoom")
	]
	
	rooms = room_order
	target_position = global_position
	
	#Get the hardcoded spawn position node
	if has_node(spawn_node_path):
		var spawn_node = get_node(spawn_node_path)
		spawn_transform = spawn_node.global_transform
	else:
		push_error("PlayerSpawnPosition node not found at: " + str(spawn_node_path))
		spawn_transform = global_transform #Fallback to current pos
		
		
	#Collect all footstep audio players
	for child in get_children():
		if child is AudioStreamPlayer3D and child.name.begins_with("FootstepAudio"):
			footstep_players.append(child)

	#Connect finished signals (to play next footstep)
	for p in footstep_players:
		p.finished.connect(_on_footstep_finished)


func _physics_process(delta):
	if is_dead:
		return
		
	if is_moving:
		var direction = target_position - global_position
		var previous_position = global_position
		
		if direction.length() < 0.05:
			#Reached target normally
			is_moving = false
			velocity = Vector3.ZERO
			stuck_timer = 0.0
			#Switch to idle animation when stopping
			if player_sprite and player_sprite.sprite_frames and player_sprite.sprite_frames.has_animation("Idle"):
				player_sprite.play("Idle")
				stop_footsteps()

		else:
			velocity = direction.normalized() * speed
			move_and_slide()
			
			#Check if "stuck" (not moving but should be)
			if global_position.distance_to(previous_position) < 0.01:
				stuck_timer += delta
				if stuck_timer >= STUCK_TIME_THRESHOLD:
					#Stuck on an obstacle, stop moving
					is_moving = false
					velocity = Vector3.ZERO
					stuck_timer = 0.0
					if player_sprite and player_sprite.sprite_frames != null and player_sprite.sprite_frames.has_animation("Idle"):
						player_sprite.play("Idle")
						stop_footsteps()

					print("Player collided with obstacle, stopping movement")
			else:
				#Moving normally, reset stuck timer
				stuck_timer = 0.0
				
			#Update facing based on movement direction
			if abs(direction.x) > 0.1:  #Only update if significant horizontal movement
				update_sprite_facing(sign(direction.x))
			#Play walk animation when moving
			if player_sprite and player_sprite.sprite_frames != null and player_sprite.sprite_frames.has_animation("Walk"):
				if player_sprite.animation != "Walk":
					player_sprite.play("Walk")
					start_footsteps()

	else:
		velocity = Vector3.ZERO
		move_and_slide()
		#Ensure idle animation when not moving
		if player_sprite and player_sprite.sprite_frames != null and player_sprite.sprite_frames.has_animation("Idle"):
			if player_sprite.animation != "Idle" and not is_moving:
				player_sprite.play("Idle")
				stop_footsteps()


	#Input controls
	if Input.is_action_just_pressed("Center 3D Spot"): #"S"
		move_to_room_center()
	elif Input.is_action_just_pressed("Left 3D Spot"): #"A"
		move_to_adjacent_room(-1)
	elif Input.is_action_just_pressed("Right 3D Spot"): #"D"
		move_to_adjacent_room(1)

#Move to center of room 
func move_to_room_center():
	var room = get_current_room()
	if room:
		var center = room.get_node(room.name + "Center")
		target_position = Vector3(center.global_position.x, global_position.y, global_position.z)
		is_moving = true
		stuck_timer = 0.0  #Reset stuck timer when starting new movement
		
		#Determine facing direction based on movement
		var move_direction = sign(target_position.x - global_position.x)
		if move_direction != 0:  #Only update if we're actually moving
			update_sprite_facing(move_direction)
		
		#Start walk animation
		if player_sprite and player_sprite.sprite_frames != null and player_sprite.sprite_frames.has_animation("Walk"):
			player_sprite.play("Walk")
			start_footsteps()


#For moving between rooms
func move_to_adjacent_room(direction: int):
	var current = get_current_room()
	if current == null:
		return
	
	#Set facing direction immediately based on input
	if direction > 0:
		player_sprite.scale.x = -0.3  #Face right
	else:
		player_sprite.scale.x = 0.3   #Face left
	
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
		#Move to next room's center
		var next_room = room_order[next_index]
		var center = next_room.get_node(next_room.name + "Center")
		target_position = Vector3(center.global_position.x, global_position.y, global_position.z)
	
	is_moving = true
	stuck_timer = 0.0  #Reset stuck timer when starting new movement
	#Start walk animation
	if player_sprite and player_sprite.sprite_frames != null and player_sprite.sprite_frames.has_animation("Walk"):
		player_sprite.play("Walk")
		start_footsteps()


#Update sprite facing direction
func update_sprite_facing(direction):
	if direction > 0:
		#Moving right - face right
		player_sprite.scale.x = -0.3
	elif direction < 0:
		#Moving left - face left
		player_sprite.scale.x = 0.3
	#If direction is 0 (already at target), keep facing the same way

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
	stuck_timer = 0.0
	#Stop any animations
	player_sprite.stop()

	#Wait before respawning
	await get_tree().create_timer(RESPAWN_DELAY).timeout
	respawn_player()

#Respawn
func respawn_player():
	#Move to PlayerSpawnPosition node's location
	global_transform = spawn_transform
	velocity = Vector3.ZERO
	is_moving = false
	is_dead = false
	visible = true
	set_process(true)
	set_physics_process(true)
	
	#Reset to idle animation on respawn
	if player_sprite and player_sprite.sprite_frames != null and player_sprite.sprite_frames.has_animation("Idle"):
		player_sprite.play("Idle")
		stop_footsteps()

	print("Respawned!")

	#ResetCamera
	var camera = get_tree().get_first_node_in_group("MainCamera")
	if camera and camera.has_method("ResetCamera"):
		camera.ResetCamera()
	else:
		print("MainCamera not found or missing ResetCamera() function.")
		
#Footstep helper functions
func start_footsteps():
	if footsteps_playing or footstep_players.is_empty():
		return
	footsteps_playing = true
	current_footstep_index = 0
	footstep_players[current_footstep_index].play()

func stop_footsteps():
	footsteps_playing = false
	for p in footstep_players:
		p.stop()

func _on_footstep_finished():
	if not footsteps_playing:
		return
	current_footstep_index = (current_footstep_index + 1) % footstep_players.size()
	footstep_players[current_footstep_index].play()

extends Node3D

#Node Paths
@onready var lock_visual = $LeftLock
@onready var blocker = $LeftArea
@onready var player = $"../Player"

var locked: bool = true
var door_anim: AnimationPlayer = null
var lock_anim: AnimationPlayer = null

func _ready() -> void:
	lock_visual.visible = locked
	blocker.visible = locked

	#Recursively find door AnimationPlayer 
	door_anim = find_animation_player(self)
	if door_anim and door_anim.has_animation("Take 001"):
		door_anim.seek(0.0, true)

	#Recursively find lock AnimationPlayer
	if lock_visual:
		lock_anim = find_animation_player(lock_visual)
		if lock_anim and lock_anim.has_animation("Take 001"):
			lock_anim.seek(0.0, true)

func _process(_delta: float) -> void:
	if locked and Input.is_action_just_pressed("unlock_left"):
		unlock_door()
		if (player.global_position.x > -2.366):
			print("!")
			player.move_to_adjacent_room(-1)
		elif (player.global_position.x < -2.366):
			player.move_to_adjacent_room(2)
			await get_tree().create_timer(1.0).timeout
			player.move_to_room_center()

func unlock_door() -> void:
	locked = false
	lock_visual.visible = false
	blocker.global_position.x = -999

	#Play lock animation first
	if lock_anim and lock_anim.has_animation("Take 001"):
		lock_anim.play("Take 001")
		await get_tree().create_timer(2.0).timeout

	#Play door animation
	if door_anim and door_anim.has_animation("Take 001"):
		door_anim.play("Take 001")
		await get_tree().create_timer(2.0).timeout
		door_anim.play_backwards("Take 001")
		locked = true
		blocker.global_position.x = -2.366

	print("Left door unlocked!")

#Recursive search for AnimationPlayer
func find_animation_player(node: Node) -> AnimationPlayer:
	if node is AnimationPlayer:
		return node
	for child in node.get_children():
		var found = find_animation_player(child)
		if found:
			return found
	return null

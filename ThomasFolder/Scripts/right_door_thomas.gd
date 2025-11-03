extends Node3D

#Node paths
@onready var lock_visual = $RightLock
@onready var blocker = $RightArea
@onready var player = $"../Player"

var locked: bool = true
var anim_player: AnimationPlayer = null

func _ready() -> void:
	lock_visual.visible = locked
	blocker.visible = locked  #For seeing in-editor

	#Find AnimationPlayer recursively
	anim_player = find_animation_player(self)
	if anim_player:
		if anim_player.has_animation("Take 001"):
			anim_player.seek(0.0, true)  # Start at initial closed pose
	else:
		push_error("No AnimationPlayer found on Right Door!")

#Unlock
func _process(_delta: float) -> void:
	if locked and Input.is_action_just_pressed("unlock_right"):
		unlock_door()
		player.move_to_adjacent_room(1)

func unlock_door() -> void:
	locked = false
	lock_visual.visible = false
	blocker.queue_free()  #Removes the StaticBody so player can walk through

	#Play door animation
	if anim_player and anim_player.has_animation("Take 001"):
		anim_player.play("Take 001")
	else:
		print("No animation found for Right Door!")

	print("Right door unlocked!")

#Recursive search for AnimationPlayer
func find_animation_player(node: Node) -> AnimationPlayer:
	if node is AnimationPlayer:
		return node
	for child in node.get_children():
		var found = find_animation_player(child)
		if found:
			return found
	return null

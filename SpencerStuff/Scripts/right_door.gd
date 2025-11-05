extends Node3D

#Node paths
@onready var lock_visual = $RightLock
@onready var blocker = $RightArea

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
	if Input.is_action_just_pressed("unlock_right"):
		unlock_door()
	elif Input.is_action_just_pressed("reverse_unlock_right"):
		reverse_unlock_door()

func unlock_door() -> void:
	locked = false
	lock_visual.visible = false
	blocker.set_collision_layer_value(1, false)  #Removes the StaticBody so player can walk through

	#Move player to door
	
	
	#Play interact animation to simulate them opening door (IN CONJUNCTION WITH NEXT METHOD)
	
	
	#Play door animation
	if anim_player and anim_player.has_animation("Take 001"):
		anim_player.play("Take 001")
		print("Right door open!")
	else:
		print("No animation found for Right Door!")
		
	#Play door close animation after some time
	if anim_player and anim_player.has_animation("Take 001"):
		await get_tree().create_timer(3.0).timeout
		anim_player.play_backwards("Take 001")
		print("Right door closed!")
		
func reverse_unlock_door():
	locked = false
	lock_visual.visible = false
	blocker.set_collision_layer_value(1, false)  #Removes the StaticBody so player can walk through

	#Move player to door
	
	
	#Play interact animation to simulate them opening door (IN CONJUNCTION WITH NEXT METHOD)
	
	
	#Play door animation
	if anim_player and anim_player.has_animation("Take 001"):
		anim_player.play("Take 001")
		print("Right door open!")
	else:
		print("No animation found for Right Door!")
		
	#Play door close animation after some time
	if anim_player and anim_player.has_animation("Take 001"):
		await get_tree().create_timer(3.0).timeout
		anim_player.play_backwards("Take 001")
		print("Right door closed!")

#Recursive search for AnimationPlayer
func find_animation_player(node: Node) -> AnimationPlayer:
	if node is AnimationPlayer:
		return node
	for child in node.get_children():
		var found = find_animation_player(child)
		if found:
			return found
	return null

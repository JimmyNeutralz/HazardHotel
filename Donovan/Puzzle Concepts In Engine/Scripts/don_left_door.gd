extends Node3D

#Node Paths
@onready var lock_visual = $LeftLock
@onready var blocker = $Door/LeftArea

var locked: bool = true
var door_anim: AnimationPlayer = null
var lock_anim: AnimationPlayer = null

func _ready() -> void:
	lock_visual.visible = locked
	#blocker.visible = locked

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
	if Input.is_action_just_pressed("unlock_left"):
		unlock_door()
	elif Input.is_action_just_pressed("reverse_unlock_left"):
		reverse_unlock_door()

func unlock_door() -> void:
	locked = false
	lock_visual.visible = false
	blocker.set_collision_layer_value(1, false)

	#Play lock animation first
	if lock_anim and lock_anim.has_animation("Take 001"):
		lock_anim.play("Take 001")
		await get_tree().create_timer(2.0).timeout
	
	
	#Play interact animation to simulate them opening door (IN CONJUNCTION WITH NEXT METHOD)
	

	#Play door open animation after player has reached it
	if door_anim and door_anim.has_animation("Take 001"):
		door_anim.play("Take 001")
		print("Left door open!")
	
	#Play door close animation after some time
	if door_anim and door_anim.has_animation("Take 001"):
		await get_tree().create_timer(3.0).timeout
		door_anim.play_backwards("Take 001")
		print("Left door closed!")

func reverse_unlock_door():
	locked = false
	lock_visual.visible = false
	blocker.set_collision_layer_value(1, false)  #Removes the StaticBody so player can walk through

	#Move player to door
	
	
	#Play interact animation to simulate them opening door (IN CONJUNCTION WITH NEXT METHOD)
	
	
	#Play door open animation after player has reached it
	if door_anim and door_anim.has_animation("Take 001"):
		door_anim.play("Take 001")
		print("Left door open!")
	
	#Play door close animation after some time
	if door_anim and door_anim.has_animation("Take 001"):
		await get_tree().create_timer(3.0).timeout
		door_anim.play_backwards("Take 001")
		print("Left door closed!")

#Recursive search for AnimationPlayer
func find_animation_player(node: Node) -> AnimationPlayer:
	if node is AnimationPlayer:
		return node
	for child in node.get_children():
		var found = find_animation_player(child)
		if found:
			return found
	return null

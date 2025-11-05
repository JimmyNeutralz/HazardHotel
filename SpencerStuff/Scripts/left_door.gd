extends Node3D

@export var lock_node_path: NodePath
@onready var lock_script = get_node(lock_node_path)

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
	if locked and Input.is_action_just_pressed("unlock_right") and name == "RightDoor":
		unlock_door()

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
	blocker.queue_free()

func find_animation_player(node: Node) -> AnimationPlayer:
	if node is AnimationPlayer:
		return node
	for child in node.get_children():
		var found = find_animation_player(child)
		if found:
			return found
	return null

extends Area2D
var interactingWith = false
var keysHeldDown = 0

func _ready() -> void:
	visible = false

func _process(delta: float) -> void:
	if (interactingWith):
		#print("Func true")
		if (Input.is_action_just_pressed("Connect First Fuse 1 Chain") or Input.is_action_just_pressed("Connect Second Fuse 1 Chain") or Input.is_action_just_pressed("Connect Third Fuse 1 Chain") or Input.is_action_just_pressed("Connect Fourth Fuse 1 Chain")):
			keysHeldDown = keysHeldDown + 1
			print(keysHeldDown)
		
		if (Input.is_action_just_released("Connect First Fuse 1 Chain") or Input.is_action_just_released("Connect Second Fuse 1 Chain") or Input.is_action_just_released("Connect Third Fuse 1 Chain") or Input.is_action_just_released("Connect Fourth Fuse 1 Chain")):
			keysHeldDown = keysHeldDown - 1
		
		if (keysHeldDown >= 4):
			visible = false
			interactingWith = false

func toggle_visibility(val):
	#print("Works!")
	visible = val
	if (val):
		interactingWith = true

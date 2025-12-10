extends Node3D

#Get animation stuff
var anim: AnimationPlayer
var door_open := false

@onready var player = $"../Player"
@onready var elevator_marker = $"../ElevatorDoor/ElevatorMarker"
@onready var uiNode = $"../ElevatorDoor/ElevatorDoorUI"
@onready var inside_elevator = $ElevatorMarker2

var powered_on = false

func _ready() -> void:
	anim = find_animation_player(self)
	print("Player:", player)
	print("Marker:", elevator_marker)
	print("UI:", uiNode)

	
	#Error check
	if anim == null:
		push_error("No AnimationPlayer found in ElevatorDoor!")
		return
	
	#Force closed at beginning of scene
	anim.play("Take 001")
	anim.seek(0.0, true)
	anim.stop()
	
func _process(delta: float) -> void:
	if (Input.is_action_just_pressed("Unlock Elevator Door") or Global.check_array(4,1)) and powered_on and !door_open:
		unlock_elevator()
	elif Input.is_action_just_released("Unlock Elevator Door"):
		lock_elevator()

func unlock_elevator():
	uiNode.visible = false
	player.move_to_specific_location(elevator_marker.global_position.x)
	print("OPEN THE GATES")
	open_gate()

func lock_elevator():
	uiNode.visible = true
	door_open = false

#Open gate
func open_gate() -> void:
	if anim and !door_open:
		door_open = true
		$ElevatorOpenSFX.play()
		anim.play("Take 001")
		


#Recursive Sarch to find animation
func find_animation_player(node: Node) -> AnimationPlayer:
	if node is AnimationPlayer:
		return node

	for c in node.get_children():
		var found = find_animation_player(c)
		if found:
			return found
	return null

extends Area2D
@export var player: CharacterBody3D
@export var elevator: Area3D

var interactingWith = false
var complete = false
var keysHeldDown = 0

var fusesGathered = 0


func _ready() -> void:
	visible = false

func _process(delta: float) -> void:
	if (interactingWith and !complete):
		#print("Func true")
		#Checks to see if the key to connect a given fuse is held down and adds 1 to keysHeldDown if that satement is true
		if (Input.is_action_just_pressed("Connect First Fuse 1 Chain") or Input.is_action_just_pressed("Connect Second Fuse 1 Chain") or Input.is_action_just_pressed("Connect Third Fuse 1 Chain") or Input.is_action_just_pressed("Connect Fourth Fuse 1 Chain")):
			keysHeldDown = keysHeldDown + 1
			print(keysHeldDown)
		
		#Checks to see if the key to connect a fuse gets released and subtracts 1 from keysHeldDown if that satement is true
		if (Input.is_action_just_released("Connect First Fuse 1 Chain") or Input.is_action_just_released("Connect Second Fuse 1 Chain") or Input.is_action_just_released("Connect Third Fuse 1 Chain") or Input.is_action_just_released("Connect Fourth Fuse 1 Chain")):
			keysHeldDown = keysHeldDown - 1
		
		if (keysHeldDown >= 4):
			visible = false
			interactingWith = false
			complete = true
			player.out_of_menu()
			player.move_to(elevator.global_position.x)

func toggle_visibility(val):
	#print("Works!")
	visible = val
	if (val):
		interactingWith = true
		
func getFuse():
	fusesGathered += 1

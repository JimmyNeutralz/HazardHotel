extends Area2D
@export var player: CharacterBody3D
@export var elevator: Area3D

var interactingWith = false
var complete = false
var keysHeldDown = 0

var fusesGathered = 0

#Makes the UI invisible upon the start of the game
func _ready() -> void:
	visible = false

func _process(delta: float) -> void:
	if (interactingWith and !complete):
		#print("Func true")
		#Checks to see if the key to connect a given fuse is held down and adds 1 to keysHeldDown if that satement is true
		#[todo]: Potentially rework this function so that it is multiple if statements as opposed to a single if
		if (Input.is_action_just_pressed("Connect First Fuse 1 Chain") or Input.is_action_just_pressed("Connect Second Fuse 1 Chain") or Input.is_action_just_pressed("Connect Third Fuse 1 Chain") or Input.is_action_just_pressed("Connect Fourth Fuse 1 Chain")):
			keysHeldDown = keysHeldDown + 1
			#print(keysHeldDown)
		
		#Checks to see if the key to connect a fuse gets released and subtracts 1 from keysHeldDown if that satement is true
		if (Input.is_action_just_released("Connect First Fuse 1 Chain") or Input.is_action_just_released("Connect Second Fuse 1 Chain") or Input.is_action_just_released("Connect Third Fuse 1 Chain") or Input.is_action_just_released("Connect Fourth Fuse 1 Chain")):
			keysHeldDown = keysHeldDown - 1
		
		#If 4 keys are held down, then the given fuse box is complete and the menu disapears
		if (keysHeldDown >= 4):
			visible = false
			interactingWith = false
			complete = true
			player.out_of_menu()
			player.move_to(elevator.global_position.x)

#Toggles the visiblity of the fuse UI and prevents new guy from moving if he interacts with it
func toggle_visibility(val):
	#print("Works!")
	visible = val
	if (val):
		interactingWith = true
		
#Function utlized to keep track of how many fuses are collected
func getFuse():
	fusesGathered += 1

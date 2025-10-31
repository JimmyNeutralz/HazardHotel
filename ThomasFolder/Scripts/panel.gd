extends Area2D
@export var player: CharacterBody3D
@export var elevator: Area3D

@onready var fusePuzzleUi = get_node("Sprite2D")
var puzzle1 = load("res://ThomasFolder/Sprites/Fuse Box Puzzle 1.png")
var puzzle2 = load("res://ThomasFolder/Sprites/Fuse Box Puzzle 2.png")

var interactingWith = false
var amountComplete = 0
var keysHeldDown = 0

var fusesGathered = 0

#Makes the UI invisible upon the start of the game
func _ready() -> void:
	visible = false

func _process(delta: float) -> void:
	if (interactingWith and amountComplete == 0 and fusesGathered == 1):
		#print("Func true")
		#Checks to see if the key to connect a given fuse is held down and adds 1 to keysHeldDown if that satement is true
		#[todo]: Potentially rework this function so that it is multiple if statements as opposed to a single if
		if (Input.is_action_just_pressed("Connect First Fuse 1 Chain") or Input.is_action_just_pressed("Connect Second Fuse 1 Chain") or Input.is_action_just_pressed("Connect Third Fuse 1 Chain") or Input.is_action_just_pressed("Connect Fourth Fuse 1 Chain")):
			keysHeldDown = keysHeldDown + 1
			print(keysHeldDown)
		
		#Checks to see if the key to connect a fuse gets released and subtracts 1 from keysHeldDown if that satement is true
		if (Input.is_action_just_released("Connect First Fuse 1 Chain") or Input.is_action_just_released("Connect Second Fuse 1 Chain") or Input.is_action_just_released("Connect Third Fuse 1 Chain") or Input.is_action_just_released("Connect Fourth Fuse 1 Chain")):
			keysHeldDown = keysHeldDown - 1
		
		#If 4 keys are held down, then the given fuse box is complete and the menu disapears
		if (keysHeldDown >= 4):
			visible = false
			interactingWith = false
			amountComplete += 1
			player.out_of_menu()
			keysHeldDown = 0
	elif (interactingWith and amountComplete >= 1 and fusesGathered >= 2):
		#print("Func true")
		#Checks to see if the key to connect a given fuse is held down and adds 1 to keysHeldDown if that satement is true
		#[todo]: Potentially rework this function so that it is multiple if statements as opposed to a single if
		if (Input.is_action_just_pressed("Connect First Fuse 2 Chain") or Input.is_action_just_pressed("Connect Second Fuse 2 Chain") or Input.is_action_just_pressed("Connect Third Fuse 2 Chain") or Input.is_action_just_pressed("Connect Fourth Fuse 2 Chain")):
			keysHeldDown = keysHeldDown + 1
			print(keysHeldDown)
		
		#Checks to see if the key to connect a fuse gets released and subtracts 1 from keysHeldDown if that satement is true
		if (Input.is_action_just_released("Connect First Fuse 2 Chain") or Input.is_action_just_released("Connect Second Fuse 2 Chain") or Input.is_action_just_released("Connect Third Fuse 2 Chain") or Input.is_action_just_released("Connect Fourth Fuse 2 Chain")):
			keysHeldDown = keysHeldDown - 1
		
		#If 4 keys are held down, then the given fuse box is complete and the menu disapears
		if (keysHeldDown >= 4):
			visible = false
			interactingWith = false
			amountComplete += 1
			player.out_of_menu()
			player.move_to(elevator.global_position.x)

#Toggles the visiblity of the fuse UI and prevents new guy from moving if he interacts with it
func toggle_visibility(val):
	#print("Works!")
	visible = val
	if (val):
		interactingWith = true
		if (amountComplete == 0):
			fusePuzzleUi.texture = puzzle1
		if (amountComplete >= 1):
			fusePuzzleUi.texture = puzzle2
#Function utlized to keep track of how many fuses are collected
func getFuse():
	fusesGathered += 1

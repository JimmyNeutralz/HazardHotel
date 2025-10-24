extends Node3D

#Node paths
@onready var left_key = $LeftWall/LeftKey
@onready var right_key = $RightWall/RightKey
@onready var elevator_lock = $Elevator/ElevatorLock
@onready var generator = $Generator

#Pause menu stuff
@onready var pause_menu_background = $PauseMenu/PauseBackground
@onready var resume_button = $PauseMenu/ResumeButton
@onready var quit_button = $PauseMenu/QuitButton

#scenes
@export var next_scene_path := "res://SpencerStuff/Scenes/EndScene.tscn"
@export var main_menu_scene := "res://SpencerStuff/Scenes/MainMenu.tscn"

#Key states
var has_left_key: bool = false
var has_right_key: bool = false

#Key triggers
func _on_left_trigger_body_entered(body: Node3D) -> void:
	if body.name == "Player" and not has_left_key:
		has_left_key = true
		left_key.visible = false
		print("Left key obtained")
		_check_keys()

func _on_right_trigger_body_entered(body: Node3D) -> void:
	if body.name == "Player" and not has_right_key:
		has_right_key = true
		right_key.visible = false
		print("Right key obtained")
		_check_keys()

func _check_keys() -> void:
	if has_left_key and has_right_key:
		elevator_lock.visible = false
		print("Elevator unlocked. Floor completed!")

func _on_area_3d_body_entered(body: Node3D) -> void:
	if generator.activated:
		get_tree().change_scene_to_file(next_scene_path)

#Pause menu stuff
func _ready():
	#Start hidden
	_set_pause_menu_visible(false)
	
	#Connect buttons
	resume_button.pressed.connect(_on_resume_pressed)
	quit_button.pressed.connect(_on_quit_pressed)

func _input(event):
	if event.is_action_pressed("pause"):
		if get_tree().paused:
			_resume_game()
		else:
			_pause_game()

#Pause/Resume Helper
func _pause_game():
	_set_pause_menu_visible(true)
	get_tree().paused = true  #Pause everything in the scene tree (freeze scene)
	print("Game Paused")

func _resume_game():
	_set_pause_menu_visible(false)
	get_tree().paused = false  #Resume the scene tree (unfreeze)
	print("Game Resumed")

func _set_pause_menu_visible(visible: bool) -> void:
	pause_menu_background.visible = visible
	resume_button.visible = visible
	quit_button.visible = visible

#Button calls
func _on_resume_pressed():
	_resume_game()

func _on_quit_pressed():
	get_tree().paused = false  #Unpause before leaving so user can interact with main menu
	get_tree().change_scene_to_file(main_menu_scene)

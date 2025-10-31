extends Node3D

#Node paths
@onready var left_key = $LeftWall/LeftKey
@onready var right_key = $RightWall/RightKey
@onready var elevator_lock = $Elevator/ElevatorLock
@onready var generator = $Generator
@onready var fade_in_static:Node3D = $Cameras/Camera/FadeInView

@onready var pause_menu_background = $PauseMenu/PauseBackground
@onready var resume_button = $PauseMenu/ResumeButton
@onready var quit_button = $PauseMenu/QuitButton

@export var next_scene_path := "res://Donovan/MODIFIEDAlphaV4.tscn"
@export var main_menu_scene = "res://SpencerStuff/Scenes/MainMenu.tscn"

#For animation
var anim_player: AnimationPlayer = null

#Key states
var has_left_key: bool = false
var has_right_key: bool = false

func _ready():
	#Start hidden
	_set_pause_menu_visible(false)
	if(!fade_in_static):
		fade_in_static = $Cameras/Camera/FadeInView
	fade_in_static._fade_static_out()
	
	#Find AnimationPlayer anywhere in this node's hierarchy
	anim_player = find_animation_player(self)
	if anim_player:
		print("Found Elevator AnimationPlayer with animations:", anim_player.get_animation_list())
		# Optional: force closed pose at start (frame 0)
		if anim_player.has_animation("Take 001"):
			anim_player.seek(0.0, true)
	else:
		push_error("No AnimationPlayer found in gate!")


#Left key area trigger
func _on_left_trigger_body_entered(body: Node3D) -> void:
	if body.name == "Player":
		if not has_left_key:
			has_left_key = true
			left_key.visible = false
			print("Left key obtained")
			_check_keys()


#Right key area trigger
func _on_right_trigger_body_entered(body: Node3D) -> void:
	if body.name == "Player":
		if not has_right_key:
			has_right_key = true
			right_key.visible = false
			print("Right key obtained")
			_check_keys()

#Check for player having both keys, open elevator
func _check_keys() -> void:
	if has_left_key and has_right_key:
		elevator_lock.visible = false
		print("Elevator unlocked. Floor completed!")


#Check for player in front of elevator and both keys found, transition
#to next level
func _on_area_3d_body_entered(body: Node3D) -> void:
	if generator.activated:
		
		#Play animation if available
		if anim_player:
			if anim_player.has_animation("Take 001"):
				anim_player.play("Take 001")
			else:
				print("No animation 'Take 001' found for gate!")
		
		var player = $Player
		if player:
			#Fully stop movement
			player.is_moving = false
			player.velocity = Vector3.ZERO

			#Stop movement logic
			player.set_process(false)
			player.set_physics_process(false)

			#Force idle animation
			if player.player_sprite \
			and player.player_sprite.sprite_frames \
			and player.player_sprite.sprite_frames.has_animation("Idle"):
				player.player_sprite.play("Idle")

		fade_in_static._exit_scene("res://SpencerStuff/Scenes/EndScene.tscn")


#Recursive search for AnimationPlayer
func find_animation_player(node: Node) -> AnimationPlayer:
	if node is AnimationPlayer:
		return node
	for child in node.get_children():
		var found = find_animation_player(child)
		if found:
			return found
	return null
		
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
 
		

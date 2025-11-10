extends Node3D

#Node paths
@onready var left_key = $LeftWall/LeftKey
@onready var right_key = $RightWall/RightKey
@onready var generator = $Generator
@onready var fade_in_static: Node3D = $Cameras/Camera/FadeInView

@onready var pause_menu_background = $PauseMenu/PauseBackground
@onready var resume_button = $PauseMenu/ResumeButton
@onready var quit_button = $PauseMenu/QuitButton

@export var next_scene_path := "res://Donovan/Puzzle Concepts In Engine/Scenes/FirstPuzzle.tscn"
@export var main_menu_scene = "res://SpencerStuff/Scenes/MainMenu.tscn"

@onready var button_audio_player: AudioStreamPlayer2D = $PauseMenu/ButtonAudioPlayer

#Level music player reference
@onready var level_music: AudioStreamPlayer3D = $LevelMusicPlayer

#Key states
var has_left_key: bool = false
var has_right_key: bool = false

#Elevator door script reference
@onready var elevator_door = $ElevatorDoor


func _ready():
	#Start hidden
	_set_pause_menu_visible(false)
	if !fade_in_static:
		fade_in_static = $Cameras/Camera/FadeInView
	fade_in_static._fade_static_out()

	#Play level music at scene start
	if level_music and level_music.stream:
		level_music.play()
	else:
		print("WARNING: Level music node missing!")



#Left key trigger
func _on_left_trigger_body_entered(body: Node3D) -> void:
	if body.name == "Player" and not has_left_key:
		has_left_key = true
		left_key.visible = false
		print("Left key obtained")
		_check_keys()


#Right key trigger
func _on_right_trigger_body_entered(body: Node3D) -> void:
	if body.name == "Player" and not has_right_key:
		has_right_key = true
		right_key.visible = false
		print("Right key obtained")
		_check_keys()


#Unlock elevator when both keys acquired
func _check_keys() -> void:
	if has_left_key and has_right_key:
		print("Elevator unlocked!")


#Player enters elevator trigger area
func _on_area_3d_body_entered(body: Node3D) -> void:
	if generator.activated and body.name == "Player":
		
		#Open elevator gate
		if elevator_door:
			elevator_door.open_gate()
		else:
			print("ERROR: ElevatorDoor script not found!")

		#Freeze JUST player movement (not the world)
		var player = $Player
		if player:
			#Stop footstep sound from continuing when player stops for elevator to open
			if player.has_method("stop_footsteps"):
				player.stop_footsteps()
			
			player.is_moving = false
			player.velocity = Vector3.ZERO
			player.set_process(false)
			player.set_physics_process(false)

			if player.player_sprite and player.player_sprite.sprite_frames and player.player_sprite.sprite_frames.has_animation("Idle"):
				player.player_sprite.play("Idle")

		#Delay scene transition while animation plays
		await get_tree().create_timer(4.0).timeout #4 seconds, adjust as desired

		#Now fade and change scene
		if get_tree().current_scene.name == "FirstPuzzle":
			fade_in_static._exit_scene("res://SpencerStuff/Scenes/EndScene.tscn")
		else:
			fade_in_static._exit_scene("res://Donovan/Puzzle Concepts In Engine/Scenes/FirstPuzzle.tscn")


#Pause input
func _input(event):
	if event.is_action_pressed("pause"):
		if get_tree().paused:
			_resume_game()
		else:
			_pause_game()


#Pause helpers
func _pause_game():
	_set_pause_menu_visible(true)
	get_tree().paused = true
	print("Game Paused")


func _resume_game():
	_set_pause_menu_visible(false)
	get_tree().paused = false
	print("Game Resumed")


func _set_pause_menu_visible(visible: bool) -> void:
	pause_menu_background.visible = visible
	resume_button.visible = visible
	quit_button.visible = visible


func _on_resume_button_pressed() -> void:
	if button_audio_player:
		button_audio_player.play()
	await get_tree().create_timer(0.1).timeout
	_resume_game()


func _on_quit_button_pressed() -> void:
	if button_audio_player:
		button_audio_player.play()
	await get_tree().create_timer(0.1).timeout
	get_tree().paused = false
	get_tree().change_scene_to_file(main_menu_scene)

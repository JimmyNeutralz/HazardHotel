extends Control

#Get audio players
@onready var music_player: AudioStreamPlayer2D = $MenuMusicPlayer
@onready var button_audio_player: AudioStreamPlayer2D = $ButtonAudioPlayer

func _ready():

	#Play menu music when menu loads
	if music_player:
		music_player.play()
		
	#Connect button signals
	var start_button = $StartButton
	var settings_button = $SettingsButton

	start_button.pressed.connect(_on_start_pressed)
	settings_button.pressed.connect(_on_settings_pressed)

func _on_start_pressed():
	#Stop menu music before scene change
	if music_player:
		music_player.stop()
		
	if button_audio_player:
		button_audio_player.play()
		
	#So that you still hear button "click" sound before scene switches
	await get_tree().create_timer(0.15).timeout

	
	#When start is pressed, go to the story intro scene
	get_tree().change_scene_to_file("res://SpencerStuff/Scenes/StoryIntro.tscn")

func _on_settings_pressed():
	if button_audio_player:
		button_audio_player.play()
		
	await get_tree().create_timer(0.1).timeout
	
	#Placeholder for now
	print("Settings menu not yet implemented.")

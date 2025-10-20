extends Control

func _ready():
	#Connect button signals
	var start_button = $StartButton
	var settings_button = $SettingsButton

	start_button.pressed.connect(_on_start_pressed)
	settings_button.pressed.connect(_on_settings_pressed)

func _on_start_pressed():
	#When start is pressed, go to the story intro scene
	get_tree().change_scene_to_file("res://SpencerStuff/Scenes/StoryIntro.tscn")

func _on_settings_pressed():
	#Placeholder for now
	print("Settings menu not yet implemented.")

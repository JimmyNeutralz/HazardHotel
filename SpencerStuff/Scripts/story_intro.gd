extends CanvasLayer

@export var next_scene_path := "res://SpencerStuff/Scenes/BetaAutoMoveCopy.tscn"
@onready var label: Label = $IntroLabel

@onready var button_audio_player: AudioStreamPlayer2D = $ButtonAudioPlayer

var full_text := """In Hazard Hotel, you solo play as a hired electrician at an infamous
monster-infested hotel. You've sent in your own new hire to navigate
through the building, while you stay behind with your trusty node box to
help him solve puzzles by accessing things through electrical currents.
To hopefully survive and — even more than that — hopefully repair
the Hazard Hotel!"""

var skip_pressed = false

func _ready() -> void:
	label.text = full_text
	label.visible_characters = 0  #Hide all text initially

	$SkipButton.pressed.connect(_on_skip_pressed)

	await type_text()

	if not skip_pressed:
		get_tree().change_scene_to_file(next_scene_path)

func type_text() -> void:
	var chars_per_second = 25.0
	var delay = 1.0 / chars_per_second

	for i in range(full_text.length()):
		if skip_pressed:
			return
		label.visible_characters = i + 1
		await get_tree().create_timer(delay).timeout

func _on_skip_pressed() -> void:
	skip_pressed = true
	label.visible_characters = full_text.length()  #Instantly reveal everything (WIP)
	
	if button_audio_player:
		button_audio_player.play()
		
	#So that you still hear button "click" sound before scene switches
	await get_tree().create_timer(0.1).timeout
	
	get_tree().change_scene_to_file(next_scene_path)

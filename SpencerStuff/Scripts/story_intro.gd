extends CanvasLayer

@export var next_scene_path := "res://SpencerStuff/Scenes/BetaAutoMoveCopy.tscn"
@onready var label: Label = $IntroLabel

#Audio references
@onready var button_audio_player: AudioStreamPlayer2D = $ButtonAudioPlayer
@onready var intro_music_player: AudioStreamPlayer2D = $IntroMusicPlayer

var full_text := """In this game, you take the role of an electrician hired to repair the derelict, haunted grounds of the dreaded Hazard Hotel. Fearing the rumors of monsters and safety code violations, you have chosen to hire a new apprentice to be your hands as you facilitate operations using the awesome power of your electrical S.P.A.R.K. switchboard. Divert power to the correct machinery to safely direct your apprentice through the building to make the proper repairs, and ensure that the decaying husk of the Hazard Hotel continues to stand, at least until you are paid."""

var skip_pressed = false

func _ready() -> void:
	#Play music track when scene starts
	if intro_music_player and intro_music_player.stream:
		intro_music_player.play()
	else:
		print("WARNING: Intro music player missing or no stream assigned!")
	
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

extends CanvasLayer

@onready var credits_label: RichTextLabel = $CreditsLabel
@onready var end_music_player: AudioStreamPlayer2D = $EndMusicPlayer

#Speed of scrolling in pixels per second
var scroll_speed: float = 60.0

#How far upward the label must travel before the scene ends
var end_y_position: float = 20.0

func _ready() -> void:
	#Play music track when scene starts
	if end_music_player and end_music_player.stream:
		end_music_player.play()
	else:
		print("WARNING: End music player missing or no stream assigned!")
	
	

var scrolling_done := false

func _process(delta: float) -> void:
	if scrolling_done:
		return  #stop moving once finished

	#Move credits upward
	credits_label.position.y -= scroll_speed * delta

	#When label reaches target, stop and delay
	if credits_label.position.y < end_y_position:
		scrolling_done = true
		credits_label.position.y = end_y_position  #snap to final position
		_on_credits_finished()



func _on_credits_finished() -> void:
	print("Credits finished!")
	
	#Delay
	await get_tree().create_timer(10.0).timeout
	
	#Go back to title screen
	get_tree().change_scene_to_file("res://SpencerStuff/Scenes/MainMenu.tscn")

	

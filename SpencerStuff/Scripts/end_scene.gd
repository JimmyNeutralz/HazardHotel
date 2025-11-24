extends CanvasLayer


@onready var end_music_player: AudioStreamPlayer2D = $EndMusicPlayer

func _ready() -> void:
	#Play music track when scene starts
	if end_music_player and end_music_player.stream:
		end_music_player.play()
	else:
		print("WARNING: End music player missing or no stream assigned!")

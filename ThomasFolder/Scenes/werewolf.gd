extends Node3D

@onready var werewolf_marker = $"../Werewolf/werewolf_marker"
@onready var player = $"../Player"
@onready var text_popup = $"../TextPopup"

var talked_with = false

func _process(delta: float) -> void:
	if (!talked_with):
		if ((player.global_position.x > (werewolf_marker.global_position.x - 0.5)) and (player.global_position.x < (werewolf_marker.global_position.x + 0.5))):
			text_popup.change_text_image(4)
			text_popup.set_text("You made it this far, but can you save this hotel? No fr tho, can you please?", 6)
			talked_with = true

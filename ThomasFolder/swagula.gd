extends Node3D

@onready var swagula_marker = $"../Swagula/swagula_marker"
@onready var player = $"../Player"
@onready var text_popup = $"../TextPopup"

var talked_with = false

func _process(delta: float) -> void:
	if (!talked_with):
		if (Input.is_action_just_pressed("Talk to Swagula")):
			player.move_to_specific_location(swagula_marker.global_position.x)
		if ((player.global_position.x > (swagula_marker.global_position.x - 0.5)) and (player.global_position.x < (swagula_marker.global_position.x + 0.5))):
			text_popup.change_text_image(2)
			text_popup.set_text("Hey guys its me swagula", 4)
			talked_with = true

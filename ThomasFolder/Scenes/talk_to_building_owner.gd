extends Node3D

@onready var owner_marker = $"../BuildingOwner/owner_marker"
@onready var player = $"../Player"
@onready var text_popup = $"../TextPopup"

var talked_with = false

func _process(delta: float) -> void:
	if (!talked_with):
		if ((player.global_position.x > (owner_marker.global_position.x - 0.5)) and (player.global_position.x < (owner_marker.global_position.x + 0.5))):
			text_popup.change_text_image(3)
			text_popup.set_text("I miss my wife", 4)
			talked_with = true

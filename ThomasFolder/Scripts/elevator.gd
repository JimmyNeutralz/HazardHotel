extends Area3D

@onready var player = $"../3dPlayer"
@onready var fuseBoxUi = $"../Camera3D/FuseBoxUi"
@onready var text = $"../Camera3D/RichTextLabel"

func _on_body_entered(body: Node3D) -> void:
	if (fuseBoxUi.amountComplete >= 2):
		player.reached_destination()
		text.first_floor_complete()

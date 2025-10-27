extends Node3D

@onready var player = $"../3dPlayer"
@onready var text = $"../Camera3D/RichTextLabel"
@onready var shelf_fuse = $"../Shelf_Fuse"

var unlocked = false

func _process(delta: float) -> void:
	if (Input.is_action_just_pressed("Open Safe")):
		player.move_to_fuse_box(global_position.x)
		unlocked = true

func _on_body_entered(body: Node3D) -> void:
	if (unlocked):
		player.reached_destination()
		shelf_fuse.grabber_aquired = true
		text.got_dino_grabber()
		await get_tree().create_timer(1.1).timeout
		player.move_to_fuse_box(shelf_fuse.global_position.x)

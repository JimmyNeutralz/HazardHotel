extends Node3D

@onready var player = $"../3dPlayer"
@onready var text = $"../Camera3D/RichTextLabel"
@onready var shelf_fuse = $"../Shelf_Fuse"

#Boolean variable to determine if the new guy should stop upon coliding with the safe
var unlocked = false

var emptied = false

#If the player presses the Z key, the safe unlocks and new gy moves to it
func _process(delta: float) -> void:
	if (Input.is_action_just_pressed("Open Safe")):
		player.move_to(global_position.x)
		unlocked = true

#Upon coliding with the safe's displaced hitbox, if it's unlocked, open it and get the dino grabber
func _on_body_entered(body: Node3D) -> void:
	if (unlocked and !emptied):
		player.reached_destination()
		shelf_fuse.grabber_aquired = true
		text.got_dino_grabber()
		await get_tree().create_timer(1.1).timeout
		player.move_to(shelf_fuse.global_position.x)
		emptied = true

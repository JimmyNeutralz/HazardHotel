extends Node3D

@onready var player = $"../3dPlayer"
@onready var text = $"../Camera3D/RichTextLabel"
@onready var shelfFuse = $"../ShelfFuse"

#Boolean variable to determine if the new guy should stop upon coliding with the safe
var unlocked = false
var gettingFuse = false
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
		shelfFuse.grabber_aquired = true
		text.got_dino_grabber()
		await get_tree().create_timer(1.1).timeout
		gettingFuse = true
		player.move_to(shelfFuse.global_position.x)
		emptied = true
		unlocked = false
	elif(unlocked and emptied):
		player.reached_destination()
		text.inspect_empty_safe()
		unlocked = false

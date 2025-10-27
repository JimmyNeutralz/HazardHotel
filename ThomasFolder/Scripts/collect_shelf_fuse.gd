extends Area3D
@onready var fuseBoxUi = $"../Camera3D/FuseBoxUi"
@onready var text = $"../Camera3D/RichTextLabel"
@onready var player = $"../3dPlayer"
@onready var hitBox = $CollisionShape3D

var grabber_aquired = false

#Upon coliding with the hitbox underneath the fuse, if the player has the grabber, stop movement and get fuse
func _on_body_entered(body: Node3D) -> void:
	if (grabber_aquired):
		player.reached_destination()
		collect_fuse()
	#print(fuseBoxUi.fusesGathered)

#Function that calls multiple functions upon collecting the fuse
func collect_fuse():
	visible = false
	fuseBoxUi.getFuse()
	remove_child(hitBox)
	text.got_shelf_fuse()

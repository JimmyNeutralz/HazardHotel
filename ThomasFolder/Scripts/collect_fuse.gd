extends Area3D
@onready var fuseBoxUi = $"../Camera3D/FuseBoxUi"
@onready var text = $"../Camera3D/RichTextLabel"
@onready var player = $"../3dPlayer"
@onready var hitBox = $CollisionShape3D

var grabber_aquired = false

func _on_body_entered(body: Node3D) -> void:
	if (grabber_aquired):
		player.reached_destination()
		collect_fuse()
	#print(fuseBoxUi.fusesGathered)

func collect_fuse():
	visible = false
	fuseBoxUi.getFuse()
	remove_child(hitBox)
	text.got_shelf_fuse()

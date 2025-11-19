extends Area3D
@onready var fuseBoxUi = $"../Camera3D/FuseBoxUi"
@onready var text = $"../Camera3D/RichTextLabel"
@onready var player = $"../3dPlayer"
@onready var hitBox = $CollisionShape3D

func _on_body_entered(body: Node3D) -> void:
	collect_fuse()

func collect_fuse():
	visible = false
	fuseBoxUi.getFuse()
	remove_child(hitBox)
	text.got_fuse()

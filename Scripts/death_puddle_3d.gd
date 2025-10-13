extends Area3D
@onready var player = $"../3dPlayer"
@onready var collideshape = get_node("CollisionShape3D")

var unsafe = true

func change_puddle_status(electrified):
	unsafe = electrified

func determine_status(inDanger):
	if (inDanger && unsafe):
		print("If met")
		player.death()

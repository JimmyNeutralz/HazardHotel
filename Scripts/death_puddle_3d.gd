extends Area3D
@onready var player = $"../3dPlayer"
@onready var collideshape = get_node("CollisionShape3D")

#Var to determine if the puddle is deadly or not
var unsafe = true

#Changes the unsafe var whenever the puddle is deactivated or reactivated
func change_puddle_status(electrified):
	unsafe = electrified

#Function that if the player is standing in the puddle 
# while it's electrified, will cause them to die
func determine_status(inDanger):
	if (inDanger && unsafe):
		print("If met")
		player.death()

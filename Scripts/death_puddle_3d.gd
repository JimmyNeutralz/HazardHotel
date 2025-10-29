extends Area3D
@onready var player = $"../3dPlayer"
@onready var collideshape = get_node("CollisionShape3D")

#Bool to determine if the puddle is deadly or not
var unsafe = true
var inDanger

#Changes the unsafe var whenever the puddle is deactivated or reactivated
func change_puddle_status(electrified):
	unsafe = electrified

#Function that if the player is standing in the puddle 
# while it's electrified, will cause them to die
func determine_status():
	if (inDanger && unsafe):
		print("If met")
		player.death()


func _on_body_entered(body: Node3D) -> void:
	inDanger = true
	determine_status()


func _on_body_exited(body: Node3D) -> void:
	inDanger = false

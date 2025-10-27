extends Area3D
@onready var player = $"../3dPlayer"
var moving = false

func _process(delta: float) -> void:
	if (Input.is_action_just_pressed("Open Fuse Box")):
		player.move_to(global_position.x)
		moving = true


#func _on_area_entered(area: CharacterBody3D) -> void:
	#print("Colided!")
	#if (moving):
		#moving = false
		#player.reached_destination()

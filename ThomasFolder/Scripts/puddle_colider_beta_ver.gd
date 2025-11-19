extends Node3D

@onready var colider = $"../PuddleColider/StaticBody3D/CollisionShape3D"

func change_puddle_colider_status(puddle_active: bool):
	if(!puddle_active):
		colider.global_position.y = -999
	else:
		colider.global_position.y = 0.737

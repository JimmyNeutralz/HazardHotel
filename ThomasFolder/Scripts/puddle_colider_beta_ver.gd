extends Node3D

@export var text_colider: Area3D
@export var physical_colider: StaticBody3D

func change_puddle_colider_status(puddle_active: bool):
	if(!puddle_active):
		text_colider.global_position.y = -999
		physical_colider.global_position.y = -999
	else:
		text_colider.global_position.y = 0.737
		physical_colider.global_position.y = 0.737

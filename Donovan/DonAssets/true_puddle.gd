extends Node3D

@onready var mesh_instance = $Puddle/pasted__puddle.get_active_material(0)


func safe_puddle():
	mesh_instance.albedo_color = Color(1.0, 1.0, 1.0, 1.0)

func yellow_puddle():
	mesh_instance.albedo_color = Color(0.75, 0.603, 0.141, 1.0)

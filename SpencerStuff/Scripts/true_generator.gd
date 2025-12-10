extends Node3D

@onready var mesh_instance = $generator/GeneratorFrame_L1.get_active_material(0)


func colored_generator():
	mesh_instance.albedo_color = Color(0.422, 0.237, 0.017, 1.0)

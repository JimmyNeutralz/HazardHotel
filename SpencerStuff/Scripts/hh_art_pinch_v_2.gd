extends Node3D

@onready var mesh_instance = $polySurface9.get_active_material(0)


func coloredFloor1():
	mesh_instance.albedo_color = Color(0.80, 0.70, 0.55, 1.0)

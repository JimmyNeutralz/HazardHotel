extends Node3D

@onready var mesh_instance = $pCube12.get_active_material(0)


func coloredElevator():
	mesh_instance.albedo_color = Color(0.29, 0.165, 0.0, 1.0)

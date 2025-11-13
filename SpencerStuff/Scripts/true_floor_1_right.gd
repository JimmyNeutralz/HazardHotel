extends Node3D

@onready var mesh_instance = $PinchModularRight.get_active_material(0)


func coloredFloor1():
	mesh_instance.albedo_color = Color(0.289, 0.24, 0.174, 1.0)

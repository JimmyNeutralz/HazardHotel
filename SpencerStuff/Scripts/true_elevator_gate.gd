extends Node3D

@onready var part1: MeshInstance3D = $ElevatorGate/pCube29
@onready var part2: MeshInstance3D = $ElevatorGate/pCube30
@onready var part3: MeshInstance3D = $ElevatorGate/pCylinder5


func coloredElevatorGate():
	_recolor(part1)
	_recolor(part2)
	_recolor(part3)

	print("Elevator gate color updated!")


func _recolor(mesh: MeshInstance3D):
	if mesh.mesh == null:
		print(mesh.name, " has no mesh")
		return

	# Get the original material from the mesh resource (where FBX stores it)
	var original_mat := mesh.mesh.surface_get_material(0)

	if original_mat == null:
		print(mesh.name, " has no surface material")
		return

	# Duplicate so we can safely edit it
	var new_mat := original_mat.duplicate()

	# Set new color
	if new_mat is StandardMaterial3D:
		new_mat.albedo_color = Color(0.918, 0.824, 0.675)
	else:
		print(mesh.name, " has non-standard material: ", new_mat)
		return

	# Override the surface MATERIAL on the MeshInstance
	mesh.set_surface_override_material(0, new_mat)

	print("Recolored: ", mesh.name)

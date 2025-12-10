extends Node3D

@onready var part1: MeshInstance3D = $gate/gate_door/gate_door2


func electrifiedGate():
	#Ensure the mesh exists
	if part1 == null:
		push_warning("Mesh not found!")
		return
	
	#Get the material currently used by this mesh
	var mat := part1.get_active_material(0)
	if mat == null:
		push_warning("No material")
		return

	#Duplicate to avoid modifying other gate
	mat = mat.duplicate()

	#Assign the unique material back onto the mesh
	part1.set_surface_override_material(0, mat)

	#Now safely change the color
	mat.albedo_color = Color(0.805, 0.785, 0.334, 1.0)

	print("Gate color updated")

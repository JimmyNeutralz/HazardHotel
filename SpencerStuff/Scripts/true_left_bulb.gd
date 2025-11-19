extends Node3D

@onready var mesh_instance_base = $Lightbulb/pasted__lightbulb/pasted__LightBulb_Base
@onready var mesh_instance_bulb = $Lightbulb/pasted__lightbulb/pasted__LightBulb

func coloredLight():
	print(mesh_instance_base) # Should now be a MeshInstance3D
	print(mesh_instance_bulb)

	var base_mat = mesh_instance_base.get_active_material(0)
	var bulb_mat = mesh_instance_bulb.get_active_material(0)

	print(base_mat)
	print(bulb_mat)

	if base_mat:
		base_mat.albedo_color = Color(0.0, 0.0, 0.0)
	if bulb_mat:
		bulb_mat.albedo_color = Color(1.0, 0.95, 0.6) # mellow bulb glow

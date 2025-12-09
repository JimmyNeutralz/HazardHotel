extends Node3D

@onready var mesh_instance = $Puddle/pasted__puddle.get_active_material(0)
@onready var puddle_safe = load("res://ThomasFolder/Objects and Textures/HH_Art_PuddleNormTexture_V1.png")
@onready var puddle_electrified = load("res://ThomasFolder/Objects and Textures/HH_Art_PuddleElecTexture_V1.png")

func safe_puddle():
	mesh_instance.set_surface_override_material(0, puddle_safe)

func yellow_puddle():
	mesh_instance.set_surface_override_material(0, puddle_electrified)

extends Node3D

@onready var puddle_material = $Puddle/pasted__puddle
@onready var puddle_material_2 = $Puddle/pasted__puddle2

func safe_puddle():
	puddle_material.visible = true
	puddle_material_2.visible = false

func yellow_puddle():
	puddle_material.visible = false
	puddle_material_2.visible = true

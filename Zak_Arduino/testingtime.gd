extends Node2D

@onready var MyCSharpScript = $Node


func _physics_process(_delta: float) -> void:
	print("|" + MyCSharpScript.serialMessage + "|")
	pass

extends Control

@onready var MyCSharpScript = $Node


func _physics_process(_delta: float) -> void:
	print(MyCSharpScript.IsPressed)
	pass

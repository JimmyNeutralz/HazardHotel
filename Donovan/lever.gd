extends Node3D

@onready var player = $"../Player"
@onready var standLoc = $standLoc
@onready var uiNode = $LeverUI


func _process(delta):
	if Input.is_action_just_pressed("raise_safe"):
		uiNode.visible = false
		

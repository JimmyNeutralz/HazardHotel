extends Node3D

@onready var player = $"../Player"
@onready var standLoc = $standLoc
@onready var uiNode = $LeverUI
@onready var fuseBox = $"../FuseBox"

var hasRun = false


func _process(delta):
	if (fuseBox.get_fuse_amount() <= 0):
		uiNode.visible = false
	elif (fuseBox.get_fuse_amount() == 1):
		uiNode.visible = true
		
	#if Input.is_action_just_pressed("lower_safe") and fuseBox.get_fuse_amount() >= 1:
		#uiNode.visible = false

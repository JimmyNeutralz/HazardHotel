extends Node3D

@onready var player = $"../Player"
@onready var uiNode = $DumbwaiterUI
@onready var standLoc = $standLoc
@onready var fuse = $fuse2
@onready var fuseBoxLoc = $"../FuseBox/standSpot"

func _process(delta):
	#Handle safe deactivation input
	if Input.is_action_just_pressed("fix_dumbwaiter"):
		player.move_to_object(standLoc)
		uiNode.visible = false
		await get_tree().create_timer(1.0).timeout
		fuse.visible = false
		player.move_to_object(fuseBoxLoc)
		

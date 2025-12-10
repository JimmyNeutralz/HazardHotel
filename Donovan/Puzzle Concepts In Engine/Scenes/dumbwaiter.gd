extends Node3D

@onready var player = $"../Player"
@onready var uiNode = $DumbwaiterUI
@onready var standLoc = $standLoc
@onready var fuse = $fuse2
@onready var fuseBoxLoc = $"../FuseBox/standSpot"
@onready var fuseBox = $"../FuseBox"

# State checking
var isActivated = false;
var anim_player: AnimationPlayer = null

func _ready() -> void:
	anim_player = find_animation_player(self)

func _process(delta):
	#Handle safe deactivation input
	
	#Global.check_array(5, 3) or
	if (Global.check_array(5, 3) or Input.is_action_pressed("fix_dumbwaiter")) and isActivated == false:
		isActivated = true
		player.move_to_object(standLoc)
		uiNode.visible = false
		await get_tree().create_timer(1.0).timeout
		open_hatch()
		await get_tree().create_timer(1.0).timeout
		fuse.visible = false
		player.collect_fuse()
		player.standing_player_interact()
		open_hatch()
		
func open_hatch():
	if anim_player and anim_player.has_animation("Take 001"):
		anim_player.play("Take 001")
	await anim_player.animation_finished
	
#Recursive search for AnimationPlayer
func find_animation_player(node: Node) -> AnimationPlayer:
	if node is AnimationPlayer:
		return node
	for child in node.get_children():
		var found = find_animation_player(child)
		if found:
			return found
	return null

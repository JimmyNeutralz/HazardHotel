extends Node3D

#Node paths
@onready var upperSafeLoc = $UpperSafe
@onready var originSafeLoc = $SafeOrigin
@onready var fuse = $"../fuse"
@onready var standSpot = $"../SafeLoc"
@onready var uiNode1 = $SafePowered
@onready var uiNode2 = $SafeOpen
@onready var player = $"../Player"
@onready var fuseStandSpot = $"../HH_Art_Shelf_V1/FuseStandSpot"
@onready var fuseBox = $"../FuseBox"
@onready var dinograbber = $DinoGrabber
@onready var fuse2 = $"../HH_Art_Fuse3_V1"
@onready var playerSprite = $"../Player/PlayerSprite"
@onready var fuseSafeSpot = $"../FuseSafeLoc"


var anim_player: AnimationPlayer = null
var realLoc
var fuseDropSpot

#State
var safe_raised = true
var has_slammed = false
var is_safe_open = false
var first_time = true
var process_started = false

func _ready():
	realLoc = originSafeLoc.global_position
	anim_player = find_animation_player(self)
	uiNode1.visible = false
	uiNode2.visible = false
	

func _process(delta):
	#Handle safe deactivation input
	if Input.is_action_pressed("raise_safe") and !safe_raised:
		if (!process_started):
			raise_safe()
	elif Input.is_action_pressed("lower_safe") and safe_raised:
		if(!process_started):
			lower_safe()
		
		
	elif Input.is_action_just_pressed("open_safe") and !is_safe_open:
		open_safe()
	elif Input.is_action_just_pressed("open_safe") and is_safe_open:
		close_safe()

func lower_safe():
	process_started = true
	var tween = create_tween()
	tween.tween_property(self, "global_position", upperSafeLoc.global_position, 0.5)
	
	if (first_time):
		tween.parallel().tween_property(fuse, "global_position", fuseSafeSpot.global_position, 0.5)
		await tween.finished
		var tween2 = create_tween()
		tween2.tween_property(fuse, "global_position", standSpot.global_position, 0.5)
		await tween2.finished
		tween2.kill()
		first_time = false
		
	await tween.finished
	tween.kill()
	print("Safe Lowered!")
	safe_raised = false
	await get_tree().create_timer(1.5).timeout
	
	player.move_to_object(standSpot)
	await get_tree().create_timer(1.5).timeout
	if playerSprite and playerSprite.sprite_frames != null and playerSprite.sprite_frames.has_animation("StandInteract"):
		print("Crouch anim started")
		playerSprite.play("StandInteract")
		await playerSprite.animation_finished
		print("Crouch animation played!")
	
	if(player.global_position.x == standSpot.global_position.x - 10 or player.global_position.x == standSpot.global_position.x + 10):
		fuse.visible = false
		fuseBox.uiNode.visible = true
		uiNode1.visible = true
		uiNode2.visible = true
	process_started = false
	

func raise_safe():
	process_started = true
	var tween = create_tween()
	tween.tween_property(self, "global_position", realLoc, 0.5)
	#update_indicator_color()
	await tween.finished
	tween.kill()
	safe_raised = true
	print("Safe Raised!")
	process_started = false
	

##Indicator Helpers
#func make_indicator_material_unique():
	#if indicator == null:
		#return
	#var mat = indicator.get_active_material(0)
	#if mat:
		#var unique_mat = mat.duplicate()
		#indicator.set_surface_override_material(0, unique_mat)
	#else:
		#indicator.set_surface_override_material(0, StandardMaterial3D.new())
#
#func update_indicator_color():
	#if indicator == null:
		#return
	#var mat = indicator.get_active_material(0)
	#if mat == null:
		#mat = StandardMaterial3D.new()
		#indicator.set_surface_override_material(0, mat)
#
	#if puddle_active:
		#mat.albedo_color = Color.GREEN  # Activated / dangerous
	#else:
		#mat.albedo_color = Color.RED    # Deactivated / safe

func open_safe():
	if anim_player and anim_player.has_animation("Take 001"):
		anim_player.play("Take 001")
		print("Safe open!")
		is_safe_open = true
		await get_tree().create_timer(1.5).timeout
		
		var tween = create_tween()
		tween.tween_property(dinograbber, "global_position", player.position, 1.0)
		await get_tree().create_timer(1.0).timeout
		dinograbber.visible = false
		
		player.move_to_object(fuseStandSpot)
		await get_tree().create_timer(1.0).timeout
		fuse2.visible = false
		fuseBox.uiNode.visible = true;
		
	
		
func close_safe():
	if anim_player and anim_player.has_animation("Take 001"):
		anim_player.play_backwards("Take 001")
		print("Safe closed!")
		is_safe_open = false
		
#Recursive search for AnimationPlayer
func find_animation_player(node: Node) -> AnimationPlayer:
	if node is AnimationPlayer:
		return node
	for child in node.get_children():
		var found = find_animation_player(child)
		if found:
			return found
	return null

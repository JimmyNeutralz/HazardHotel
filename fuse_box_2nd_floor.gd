extends Node3D

#NodePath
@onready var player = $"../Player"
@onready var fuseboxStand = $standSpot
@onready var uiNode = $FuseboxUI
@onready var player_sprite = $"../Player/PlayerSprite"

@onready var text = $"../TextPopup"
var dialogue_step = 0
var fuses_collected = 0

#Path to puddle node
@export var puddle_node_path : NodePath
var puddle : Node = null

#Animation player reference
var anim_player: AnimationPlayer = null

#Activation state
var activated = false

func _ready():
	#Get puddle node
	if puddle_node_path != null:
		puddle = get_node(puddle_node_path)
	else:
		push_error("Puddle node path not set for Fusebox!")

	#Find AnimationPlayer anywhere in this node's hierarchy
	anim_player = find_animation_player(self)
	if anim_player:
		print("Found AnimationPlayer with animations:", anim_player.get_animation_list())

		#IRELEVANT
		#Force model to start in closed pose (frame 0 of animation)
		if anim_player.has_animation("Take 001"):
			anim_player.seek(0.0, true)  #0.0 seconds, update immediately
	else:
		push_error("No AnimationPlayer found in fusebox!")

func _process(delta):
	if Input.is_action_just_pressed("activate_fusebox") and player.get_fuse_state():
		# Move player to fusebox
		player.move_to_fusebox(fuseboxStand)
		
		# Play fusebox animation
		uiNode.visible = false
		activate()
		player.deposit_fuse()
		fuses_collected = fuses_collected + 1

	elif Input.is_action_just_pressed("activate_fusebox") and activated:
			deactivate()
			
	# Test for resource budgeting
	#if (Global.check_array(1, 0)):
		#uiNode.visible = true
	#else:
		#uiNode.visible = false


#Check if the fusebox can be activated
func can_activate() -> bool:
	if puddle == null:
		return false

	var puddle_active = puddle.get("puddle_active")
	var player_dead = puddle.get("player_dead")

	if puddle_active:
		return false
	if player_dead:
		return false
	return true

#Activate fusebox
func activate():
	if (player.get_fuse_state() and player.fuseAmount > 0):
		#activated = true
		$FuseboxAudio.play()
		print("Fusebox opened!")

		#Play animation if available
		if anim_player:
			#Try "Take 001" first, otherwise play first animation
			var anim_name = "Take 001"
			if not anim_player.has_animation(anim_name) and anim_player.get_animation_list().size() > 0:
				anim_name = anim_player.get_animation_list()[0]
			if anim_player.has_animation(anim_name):
				anim_player.play(anim_name)
			else:
				print("No animations found to play!")
		else:
			print("No AnimationPlayer found to play animation!")
			
		player.standing_player_interact()
		await player_sprite.animation_finished
		
		#Dialogue functions
		if dialogue_step == 0:
			text.change_text_image(1)
			text.set_text("Got that fuse in place, sounds like something powered from the right room", 6)
			dialogue_step = dialogue_step + 1
		elif dialogue_step == 1:
			text.change_text_image(1)
			text.set_text("Another fuse in place, sounds like something else has powered on the right", 6)
			dialogue_step = dialogue_step + 1
		elif dialogue_step == 2:
			text.change_text_image(1)
			text.set_text("Last fuse in, the gate should be powered now", 6)
			dialogue_step = dialogue_step + 1
			
	fuses_collected = fuses_collected + player.fuseAmount
	player.fuseAmount = 0
	print(fuses_collected)
		
func deactivate():
	
	
	activated = false
	$FuseboxAudio.play()
	print("Electric gate reactivated through fusebox!")

	#Play animation if available
	if anim_player:
		#Try "Take 001" first, otherwise play first animation
		var anim_name = "Take 001"
		if not anim_player.has_animation(anim_name) and anim_player.get_animation_list().size() > 0:
			anim_name = anim_player.get_animation_list()[0]
		if anim_player.has_animation(anim_name):
			anim_player.play_backwards(anim_name)
		else:
			print("No animations found to play!")
	else:
		print("No AnimationPlayer found to play animation!")

#func collect_fuse():
	#fuses_collected = fuses_collected + 1
	
func get_fuse_amount():
	return fuses_collected
#Recursive search for AnimationPlayer
func find_animation_player(node: Node) -> AnimationPlayer:
	if node is AnimationPlayer:
		return node
	for child in node.get_children():
		var found = find_animation_player(child)
		if found:
			return found
	return null

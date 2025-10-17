extends Node3D

#NodePath
@onready var indicator = $"../Indicators/FuseboxIndicator"

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

	#Make indicator material unique
	make_indicator_material_unique()
	update_indicator_color()

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
	if Input.is_action_just_pressed("activate_fusebox") and not activated:
		if can_activate():
			activate()
		else:
			print("Cannot activate fusebox yet!")

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
	activated = true
	update_indicator_color()
	print("Electric gate deactivated through fusebox!")

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

#Indicator helpers
func make_indicator_material_unique():
	var mat = indicator.get_active_material(0)
	if mat:
		var unique_mat = mat.duplicate()
		indicator.set_surface_override_material(0, unique_mat)
	else:
		indicator.set_surface_override_material(0, StandardMaterial3D.new())

func update_indicator_color():
	var mat = indicator.get_active_material(0)
	if mat == null:
		mat = StandardMaterial3D.new()
		indicator.set_surface_override_material(0, mat)
	if activated:
		mat.albedo_color = Color.RED
	else:
		mat.albedo_color = Color.GREEN

#Recursive search for AnimationPlayer
func find_animation_player(node: Node) -> AnimationPlayer:
	if node is AnimationPlayer:
		return node
	for child in node.get_children():
		var found = find_animation_player(child)
		if found:
			return found
	return null

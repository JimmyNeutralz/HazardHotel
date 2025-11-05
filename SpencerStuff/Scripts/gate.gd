extends Node3D

#Node paths
@onready var sprite = $Metal
@onready var electric_sprite = $Electric
@onready var collision = $StaticBody3D/CollisionShape3D
@onready var gate_trigger = $GateTrigger
@onready var indicator = $"../Indicators/GateIndicator"  #Indicator
@onready var generator_marker = $"../Gate/GeneratorMarker"

#Path to player node
@onready var player = $"../Player"

#Fusebox reference
@export var fusebox_indicator_path : NodePath  
var fusebox_indicator : MeshInstance3D = null

#For animation
var anim_player: AnimationPlayer = null

#State
var electrified = true
var raised = false
var player_dead = false

func _ready():
	if fusebox_indicator_path != null:
		fusebox_indicator = get_node(fusebox_indicator_path)
	else:
		push_error("FuseboxIndicator path not set for Gate!")

	# Connect trigger
	if gate_trigger:
		gate_trigger.connect("body_entered", Callable(self, "_on_gate_trigger_body_entered"))
	else:
		push_error("Gate trigger not assigned!")


	make_indicator_material_unique()
	update_electric_state()

	#Find AnimationPlayer anywhere in this node's hierarchy
	anim_player = find_animation_player(self)
	if anim_player:
		print("Found Gate AnimationPlayer with animations:", anim_player.get_animation_list())
		# Optional: force closed pose at start (frame 0)
		if anim_player.has_animation("Take 001"):
			anim_player.seek(0.0, true)
	else:
		push_error("No AnimationPlayer found in gate!")


func _process(delta):
	#Continuously check for fusebox state updates - not efficient, probably change in future
	update_electric_state()

	#Handle gate raising input
	if Input.is_action_just_pressed("raise_gate") and not raised:
		if can_raise():
			raise_gate()
			player.move_to_specific_location(generator_marker.global_position.x)
		else:
			print("Cannot raise gate yet — still electrified!")

func update_electric_state():
	if fusebox_indicator == null:
		return

	var mat = fusebox_indicator.get_active_material(0)
	if mat == null:
		return

	#RED = safe (fusebox off), GREEN = powered
	if mat.albedo_color == Color.GREEN:
		electrified = true
	else:
		electrified = false

	electric_sprite.visible = electrified
	#DO NOT change gate_trigger.monitoring dynamically
	update_indicator_color() 


func can_raise() -> bool:
	return not electrified  #Only raise gate when safe

func raise_gate():
	raised = true

	#Play animation if available
	if anim_player:
		if anim_player.has_animation("Take 001"):
			anim_player.play("Take 001")
		else:
			print("No animation 'Take 001' found for gate!")
	else:
		#Fallback: just hide the sprite like before
		if sprite:
			sprite.visible = false

	if collision:
		collision.disabled = true
	print("Gate raised!")


func kill_player(player):
	print("Player electrocuted by gate!")
	player.kill_player()

#Handle indicators being weird
func make_indicator_material_unique():
	if indicator == null:
		return
	var mat = indicator.get_active_material(0)
	if mat:
		var unique_mat = mat.duplicate()
		indicator.set_surface_override_material(0, unique_mat)
	else:
		indicator.set_surface_override_material(0, StandardMaterial3D.new())

func update_indicator_color():
	if indicator == null:
		return

	var mat = indicator.get_active_material(0)
	if mat == null:
		mat = StandardMaterial3D.new()
		indicator.set_surface_override_material(0, mat)

	if electrified:
		mat.albedo_color = Color.GREEN  #Powered on / dangerous
	else:
		mat.albedo_color = Color.RED    #Safe / deactivated
		
# Recursive search for AnimationPlayer
func find_animation_player(node: Node) -> AnimationPlayer:
	if node is AnimationPlayer:
		return node
	for child in node.get_children():
		var found = find_animation_player(child)
		if found:
			return found
	return null


#Re-did collision 
func _on_gate_trigger_body_entered(body: Node3D) -> void:
	print("Body entered gate trigger:", body, "Layer:", body.collision_layer)
	if electrified and body.name == "Player":
		print("Player electrocuted!")
		kill_player(body)

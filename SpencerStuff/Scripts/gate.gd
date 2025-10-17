extends Node3D

#Node paths
@onready var sprite = $Metal
@onready var electric_sprite = $Electric
@onready var collision = $StaticBody3D/CollisionShape3D
@onready var gate_trigger = $GateTrigger
@onready var indicator = $"../Indicators/GateIndicator"  #Indicator

#Fusebox reference
@export var fusebox_indicator_path : NodePath  
var fusebox_indicator : MeshInstance3D = null

#State
var electrified = true
var raised = false
var player_dead = false

func _ready():
	if fusebox_indicator_path != null:
		fusebox_indicator = get_node(fusebox_indicator_path)
	else:
		push_error("FuseboxIndicator path not set for Gate!")

	#Connect trigger
	if gate_trigger.has_signal("body_entered"):
		gate_trigger.body_entered.connect(_on_gate_trigger_body_entered)

	make_indicator_material_unique()
	update_electric_state()

func _process(delta):
	#Continuously check for fusebox state updates - not efficient, probably change in future
	update_electric_state()

	#Handle gate raising input
	if Input.is_action_just_pressed("raise_gate") and not raised:
		if can_raise():
			raise_gate()
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
	gate_trigger.monitoring = electrified
	update_indicator_color() 

func can_raise() -> bool:
	return not electrified  #Only raise gate when safe

func raise_gate():
	raised = true
	if sprite:
		sprite.visible = false
	if collision:
		collision.disabled = true
	print("Gate raised!")

func _on_gate_trigger_body_entered(body):
	if not electrified:
		return

	if body.name == "Player":
		kill_player(body)
	else:
		print("An object touched the electrified gate: ", body.name)

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

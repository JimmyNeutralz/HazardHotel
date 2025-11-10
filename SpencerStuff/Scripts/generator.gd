extends Node3D

#node path for generator
@onready var indicator = $"../Indicators/GeneratorIndicator"  
#path to gate node assigned in inspector
@export var gate_node_path : NodePath 
@onready var elevator_lock = $"../Elevator/ElevatorLock"                     

var gate : Node3D = null
var activated = false

func _ready():
	if gate_node_path != null:
		gate = get_node(gate_node_path)
	else:
		push_error("Gate node path not set for Generator!")

func _process(delta):
	if Input.is_action_just_pressed("activate_generator") and not activated:
		if can_activate():
			activate_generator()
		else:
			print("Cannot activate generator yet!")

func can_activate() -> bool:
	if gate == null:
		return false

	#get state of gate (raised or not)
	var gate_raised = false
	if "raised" in gate:
		gate_raised = gate.get("raised")

	return gate_raised

func activate_generator():
	activated = true
	$GeneratorAudio.play()
	print("Generator activated!")

	#change color
	if indicator:
		var mat = indicator.get_active_material(0)
		if mat:
			mat.albedo_color = Color.GREEN

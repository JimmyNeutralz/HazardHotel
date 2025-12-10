extends Node3D

#node path for generator
@onready var indicator = $"../Indicators/GeneratorIndicator"  
#path to gate node assigned in inspector
@export var gate_node_path : NodePath 
@onready var elevatordoor = $"../ElevatorDoor"
@onready var uiNode = $"../Gate/GateUI"     
@onready var uiNode2 = $GeneratorUI
@onready var Player = $"../Player"
@onready var MoveToObject = $HH_Art_Generator_V2


@onready var text = $"../Overlay/TextPopup"                    

var gate : Node3D = null
var activated = false

func _ready():
	
	if gate_node_path != null:
		gate = get_node(gate_node_path)
	else:
		push_error("Gate node path not set for Generator!")
		
func _process(delta):
	if (Input.is_action_just_pressed("activate_generator") or Global.check_array(1,6)) and not activated:
		if can_activate():
			activate_generator()
			uiNode.visible = false
			uiNode2.visible = false
			text.change_text_image(1)
			Player.move_to_object(MoveToObject)
			await get_tree().create_timer(0.2).timeout
			Player.standing_player_interact()
			await get_tree().create_timer(1).timeout
			Player.standing_interact_start = false
			text.set_text("Generator up and running for this floor. Better head back to the elevator.", 6)
		else:
			print("Cannot activate generator yet!")
			
	## Test for resource budgeting
	#if (Global.check_array(1, 0)):
		#uiNode.visible = true
	#else:
		#uiNode.visible = false

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
	elevatordoor.powered_on = true
	##change color
	#if indicator:
		#var mat = indicator.get_active_material(0)
		#if mat:
			#mat.albedo_color = Color.GREEN

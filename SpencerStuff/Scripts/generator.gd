extends Node3D

#node path for generator
@onready var indicator = $"../Indicators/GeneratorIndicator"  
#path to gate node assigned in inspector
@export var gate_node_path : NodePath 
@onready var elevator_lock = $"../ElevatorDoor/ElevatorLock"       
@onready var uiNode = $"../Gate/GateUI"     
@onready var uiNode2 = $GeneratorUI
@onready var player = $"../Player"

@onready var text = $"../Overlay/TextPopup"                    

var gate : Node3D = null
var activated = false

var can_interact = false

func _ready():
	if gate_node_path != null:
		gate = get_node(gate_node_path)
	else:
		push_error("Gate node path not set for Generator!")

func _process(delta):
	if Input.is_action_just_pressed("activate_generator") and not can_interact:
		if can_activate():
			
			activate_generator()
			#uiNode.visible = false
			#uiNode2.visible = false
			#text.change_text_image(1)
			#text.set_text("Generator up and running for this floor. Better head back to the elevator.", 6)
		else:
			print("Cannot activate generator yet!")
	if Input.is_action_just_released("activate_generator") and can_interact:
		deactivate_generator()
		
	if !activated:
		if (((player.global_position.x >= (global_position.x + 0.25)) and (player.global_position.x >= (global_position.x - 0.25))) and can_interact):
			print("Generator activated!")
			$GeneratorAudio.play()
			activated = true
		
			uiNode.visible = false
			text.change_text_image(3)
			complete_generator_text()
		#elif (((player.global_position.x < (global_position.x + 0.25)) and (player.global_position.x >= (global_position.x - 0.25))) and !can_interact):
			#lamp.generator_on = true
			#text.change_text_image(3)
			#incomplete_tutorial_generator_text()
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
	can_interact = true
	
	player.move_to_specific_location(self.global_position.x)

func deactivate_generator():
	can_interact = false

	##change color
	#if indicator:
		#var mat = indicator.get_active_material(0)
		#if mat:
			#mat.albedo_color = Color.GREEN

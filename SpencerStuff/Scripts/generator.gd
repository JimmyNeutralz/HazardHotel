extends Node3D

#node path for generator
@onready var indicator = $"../Indicators/GeneratorIndicator"  
#path to gate node assigned in inspector
@export var gate_node_path : NodePath 
@onready var elevatordoor = $"../ElevatorDoor"
@onready var uiNode = $"../Gate/GateUI"     
@onready var uiNode2 = $GeneratorUI
@onready var player = $"../Player"

@onready var text = $"../Overlay/TextPopup"                    

var gate : Node3D = null
var activated = false
var can_interact = true

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
	if Input.is_action_just_released("activate_generator") and activated:
		deactivate_generator()

	if (!(player.is_moving) and (player.global_position.x <= -6.5) and !activated and can_interact):
		player.standing_player_interact()
		uiNode.visible = false
		uiNode2.visible = false
		text.change_text_image(1)
		activated = true
		$GeneratorAudio.play()
		print("Generator activated!")
		elevatordoor.powered_on = true
		complete_normal_generator_text()
		#change color
		if indicator:
			var mat = indicator.get_active_material(0)
			if mat:
				mat.albedo_color = Color.GREEN
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
	
	player.move_to_specific_location(global_position.x)

func deactivate_generator():
	can_interact = false

func complete_normal_generator_text():
	var path := get_tree().current_scene.scene_file_path
	if path == "res://Sam the Cool One/SamPuzzleWIP.tscn":
		text.set_text("That's should be the last generator done. Now just need to head back to the elevator.", 6)
	else:
		text.set_text("Generator up and running for this floor. Better head back to the elevator.", 6)

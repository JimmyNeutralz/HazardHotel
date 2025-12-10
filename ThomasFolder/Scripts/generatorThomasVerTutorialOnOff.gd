extends Node3D

#node path for generator
@onready var indicator = $"../Indicators/GeneratorIndicator"  
#path to gate node assigned in inspector
@export var lamp_node_path : NodePath 
@export var elevator_door: Node3D
@onready var elevator_lock = $"../ElevatorDoor/ElevatorLock"          
@onready var uiNode = $GeneratorUI

@onready var player = $"../Player"
@onready var text = $"../Overlay/TextPopup"      
@onready var generator_marker = $"../Generator/Marker3D"     

@onready var mesh_instance = $generator/GeneratorFrame_L1.get_active_material(0)


func colored_generator():
	mesh_instance.albedo_color = Color(0.422, 0.237, 0.017, 1.0)         

var lamp: Node3D = null
var activated = false

var can_interact = false

var failed_interact = false

func _ready():
	if lamp_node_path != null:
		lamp = get_node(lamp_node_path)
	else:
		push_error("Gate node path not set for Generator!")

func _process(delta):
	#print(can_interact)
	if (Global.check_array(3, 2) or Input.is_action_just_pressed("activate_generator")) and not can_interact and not activated:
		if can_activate():
			activate_generator()
		else:
			print("Cannot activate generator yet!")
	if (!Global.check_array(3, 2) or Input.is_action_just_released("activate_generator")) and can_interact:
		deactivate_generator()
	if !activated:
		if (((player.global_position.x < (generator_marker.global_position.x + 0.25)) and (player.global_position.x >= (generator_marker.global_position.x - 0.25))) and can_interact):
			print("Generator activated!")
			player.standing_player_interact()
			$GeneratorAudio.play()
			activated = true
		
			uiNode.visible = false
			text.change_text_image(3)
			complete_tutorial_generator_text()
			lamp.generator_on = true
			elevator_door.powered_on = true
		elif (((player.global_position.x < (generator_marker.global_position.x + 0.25)) and (player.global_position.x >= (generator_marker.global_position.x - 0.25))) and !can_interact):
			player.standing_player_interact()
			lamp.generator_on = true
			text.change_text_image(3)
			incomplete_tutorial_generator_text()

		#change color
		if indicator:
			var mat = indicator.get_active_material(0)
			if mat:
				mat.albedo_color = Color.GREEN

func can_activate() -> bool:
	if lamp == null:
		return false

	#get state of lamp (on or not)
	var lamp_raised = false
	if "lamp_on" in lamp:
		lamp_raised = lamp.get("lamp_on")

	return lamp_raised

func activate_generator():
	can_interact = true
	
	player.move_to_specific_location(generator_marker.global_position.x)

func deactivate_generator():
	can_interact = false

func incomplete_tutorial_generator_text():
	if !failed_interact:
		text.set_text("You will also need to keep the connection you used plugged in until your co-worker is done activating the generator.", 6)
		failed_interact = true

func complete_tutorial_generator_text():
	var path := get_tree().current_scene.scene_file_path
	if lamp.dialogue_finished:
		text.set_text("That’s all you have to do each floor. Just solve puzzles, activate the generator, and take the elevator until all floors are done", 7)
	else:
		text.set_text("At least you read the job description. Anyways, you’ll just have to activate those generators for each floor.", 6)

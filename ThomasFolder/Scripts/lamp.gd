extends Node3D

@onready var lamp_light = $"../HH_Art_Lobby_Lamp_V1/OmniLight3D"
@onready var middle_light = $"../Lights/MiddleRoomLight"
@onready var directional_light = $"../Lights/DirectionalLight3D"
@onready var text_popup = $"../Overlay/TextPopup"
@onready var building_owner_marker = $"../BuildingOwner/Marker3D"
@onready var player = $"../Player"
@onready var uiNode = $LampUI

var lamp_on = false
var generator_on = false
var dialogue_finished = false
var dialogue_started = false

var paused = false

func _ready() -> void:
	lamp_light.light_energy = 0
	middle_light.light_energy = 0
	directional_light.light_energy = 0.15
	
func _process(delta: float) -> void:
	if !dialogue_started:
		#if Global.check_array(2, 3) and !lamp_on:
			#activate_lights()
		#if !(Global.check_array(2, 3)) and lamp_on:
			#deactivate_lights()
			
		if Global.check_array(2, 3) or Input.is_action_pressed("turn_on_lamp") and !lamp_on:
			activate_lights()
		
		if (((player.global_position.x < (building_owner_marker.global_position.x + 0.5)) and (player.global_position.x >= (building_owner_marker.global_position.x - 0.5))) and lamp_on):
			dialogue_started = true
			player.move_to_specific_location(building_owner_marker.global_position.x)
			text_popup.change_text_image(3)
			text_popup.set_text("I was wondering who was ominously standing in the dark. I suppose you’re here to fix the electrical issues, right?", 6)
			await get_tree().create_timer(5.85, false).timeout
			if !generator_on:
				text_popup.change_text_image(1)
				text_popup.set_text("Yep, along with the electrician watching through the cameras.", 5)
				await get_tree().create_timer(4.85, false).timeout
				if !generator_on:
					dialogue_finished = true
					text_popup.change_text_image(3)
					text_popup.set_text("Well, they’ll want to use that S.P.A.R.K board to activate that generator next to me the same way they activated the light.", 7)

func activate_lights():
	lamp_on = true
	uiNode.visible = false
	lamp_light.light_energy = 0.1
	middle_light.light_energy = 1.
	directional_light.light_energy = 1
	if !dialogue_started:
		player.move_to_specific_location(building_owner_marker.global_position.x)

func deactivate_lights():
	lamp_on = false
	uiNode.visible = true
	lamp_light.light_energy = 0
	middle_light.light_energy = 0
	directional_light.light_energy = 0.15

func wait_after_delay():
	print(text_popup.displayFor)
	await get_tree().create_timer(text_popup.displayFor).timeout

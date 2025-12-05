extends Node3D

@onready var lamp_light = $"../HH_Art_Lobby_Lamp_V1/OmniLight3D"
@onready var middle_light = $"../Lights/MiddleRoomLight"
@onready var directional_light = $"../Lights/DirectionalLight3D"
@onready var text_popup = $"../TextPopup"
@onready var building_owner_marker = $"../BuildingOwner/Marker3D"
@onready var player = $"../Player"
@onready var uiNode = $LampUI

var lamp_on = false
var generator_on = false
var dialogue_finished = false
var dialogue_started = false

func _ready() -> void:
	lamp_light.light_energy = 0
	middle_light.light_energy = 0
	directional_light.light_energy = 0.15
	
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("turn_on_lamp") and !lamp_on:
		activate_lights()
	if Input.is_action_just_released("turn_on_lamp") and lamp_on:
		deactivate_lights()

func activate_lights():
	lamp_on = true
	uiNode.visible = false
	lamp_light.light_energy = 2.
	middle_light.light_energy = 1.
	directional_light.light_energy = 1
	if !dialogue_started:
		dialogue_started = true
		player.move_to_specific_location(building_owner_marker.global_position.x)
		text_popup.change_text_image(3)
		text_popup.set_text("I was wondering who was ominously standing in the dark. I suppose you’re here to fix the electrical issue, right?", 6)
		await get_tree().create_timer(6.0).timeout
		if !generator_on:
			text_popup.change_text_image(1)
			text_popup.set_text("Yep, along with the electrician watching through the cameras.", 5)
			await get_tree().create_timer(5.0).timeout
			if !generator_on:
				dialogue_finished = true
				text_popup.change_text_image(3)
				text_popup.set_text("Well, they’ll want to use that S.P.A.R.K board to activate that generator next to me the same way they activated the light.", 7)

func deactivate_lights():
	player.move_to_specific_location(building_owner_marker.global_position.x)
	lamp_on = false
	uiNode.visible = true
	lamp_light.light_energy = 0
	middle_light.light_energy = 0
	directional_light.light_energy = 0.15

extends Node2D

@onready var text_label = $"../TextPopup/text"
@onready var character_image = $"../TextPopup/TextPopupCharacterImage"
@onready var textbox_sprite = $"../TextPopup/Textbox"
@onready var character_image_back = $"../TextPopup/CharacterImageBack"

var text_input
var displayFor = 0

var new_guy_text_sprite = load("res://ThomasFolder/Sprites/HH_Art_NewGuyPortrait_V1.png")
var swagula_text_sprite = load("res://ThomasFolder/Sprites/HH_Art_SwagulaPortrait_V1.png")
var building_owner_text_sprite = load("res://ThomasFolder/Sprites/HH_Art_OwnerPortrait_V1.png")
var werewolf_text_sprite = load("res://ThomasFolder/Objects and Textures/HH_Art_WerewolfPortrait_V1.png")

var new_guy_textbox = load("res://ThomasFolder/Sprites/HH_Art_Textbox_NewGuy_V1.png")
var swagula_textbox = load("res://ThomasFolder/Sprites/HH_Art_Textbox_Swagula_V1.png")
var building_owner_textbox = load("res://ThomasFolder/Sprites/HH_Art_Textbox_Manager_V1.png")
var werewolf_textbox = load("res://ThomasFolder/Objects and Textures/HH_Art_Textbox_Werewolf_V1.pngppp")

var new_guy_sprite_back = load("res://ThomasFolder/Sprites/New Guy Character Image Back.png")
var swagula_sprite_back = load("res://ThomasFolder/Sprites/Swagula Character Image Back.png")
var building_owner_sprite_back = load("res://ThomasFolder/Sprites/Manager Character Image Back.png")
var werewolf_sprite_back = load("res://ThomasFolder/Sprites/Werewolf Character Image Back.png")

#var loop_end = false

var text_displayed = false

var type_text_running = false
var break_for_loop = false
var paused = false

func _ready() -> void:
	character_image.texture = new_guy_text_sprite

func _process(delta: float) -> void:
	#print(displayFor)
	displayFor -= delta
	if (displayFor <= 0 and text_displayed and text_label.global_position.y > -74):
		text_displayed = false
		hide_textbox()

func change_text_image(character):
	#Switches the image of the character next to the dialogue box to new guy
	if (character == 1):
		character_image.texture = new_guy_text_sprite
		textbox_sprite.texture = new_guy_textbox
		character_image_back.texture = new_guy_sprite_back
	#Switches the image of the character next to the dialogue box to swagula
	elif (character == 2):
		character_image.texture = swagula_text_sprite
		textbox_sprite.texture = swagula_textbox
		character_image_back.texture = swagula_sprite_back
	elif (character == 3):
		character_image.texture = building_owner_text_sprite
		textbox_sprite.texture = building_owner_textbox
		character_image_back.texture = building_owner_sprite_back
	elif (character == 4):
		character_image.texture = werewolf_text_sprite
		textbox_sprite.texture = werewolf_textbox
		character_image_back.texture = werewolf_sprite_back

func set_text(func_text_input: String, time_up: int):
	#if (text_displayed):
		#loop_end = true
	text_label.text = func_text_input
	text_input = func_text_input
	#text_label.visible_characters = 0
	if (!text_displayed):
		show_textbox()
	displayFor = time_up
	if(type_text_running):
		break_for_loop = true
	type_text()

func show_textbox():
	text_displayed = true
	var tween = create_tween()
	tween.tween_property(self, "global_position", Vector2(0,150.0), .8)
	#await get_tree().create_timer(6).timeout
	#hide_textbox()

func hide_textbox():
	var tween = create_tween()
	tween.tween_property(self, "global_position",  Vector2(0,-20.0), .8)

#var stored_i = 0
#var i_on_resume = 0


var waiting = false
#Type_text function repurposed from spencer's code from StoryIntro
func type_text() -> void:
	type_text_running = true
	var chars_per_second = 25.0
	var delay = 1.0 / chars_per_second
	text_label.visible_characters = 0

	for i in range(text_input.length()):
		#else:
		text_label.visible_characters = i + 1
		await get_tree().create_timer(delay, false).timeout
		
		if break_for_loop:
			break_for_loop = false
			break
		if i >= text_input.length():
			type_text_running = false
			break_for_loop = false
			
	type_text_running = false
	

extends Node2D

@onready var text_label = $"../TextPopup/text"
@onready var character_image = $"../TextPopup/TextPopupCharacterImage"

var text_input
var displayFor = 0

var new_guy_text_sprite = load("res://ThomasFolder/Sprites/Budget New Guy.png")
var swagula_text_sprite = load("res://ThomasFolder/Sprites/Budget Swagula.png")

var text_displayed = false

func _ready() -> void:
	character_image.texture = new_guy_text_sprite

func _process(delta: float) -> void:
	displayFor -= delta
	if (displayFor <= 0 and text_displayed and text_label.global_position.y > -74):
		text_displayed = false
		hide_textbox()

func change_text_image(character):
	#Switches the image of the character next to the dialogue box to new guy
	if (character == 1):
		character_image.texture = new_guy_text_sprite
	#Switches the image of the character next to the dialogue box to swagula
	elif (character == 2):
		character_image.texture = swagula_text_sprite

func set_text(func_text_input: String, time_up: int):
	text_label.text = func_text_input
	text_input = func_text_input
	#text_label.visible_characters = 0
	if (!text_displayed):
		show_textbox()
	displayFor = time_up
	type_text()

func show_textbox():
	text_displayed = true
	var tween = create_tween()
	tween.tween_property(self, "global_position", Vector2(0,105.0), .8)
	#await get_tree().create_timer(6).timeout
	#hide_textbox()

func hide_textbox():
	var tween = create_tween()
	tween.tween_property(self, "global_position",  Vector2(0,0.0), .8)

#Type_text function repurposed from spencer's code from StoryIntro
func type_text() -> void:
	var chars_per_second = 25.0
	var delay = 1.0 / chars_per_second

	for i in range(text_input.length()):
		text_label.visible_characters = i + 1
		await get_tree().create_timer(delay).timeout

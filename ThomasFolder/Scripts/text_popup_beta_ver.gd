extends Node2D

@onready var text_label = $"../TextPopup/text"
@onready var character_image = $"../TextPopup/TextPopupCharacterImage"

var text_input
var displayFor = 0

var new_guy_text_sprite = load("res://ThomasFolder/Sprites/Budget New Guy.png")
var swagula_text_sprite = load("res://ThomasFolder/Sprites/Budget Swagula.png")

var text_displayed = true

func _ready() -> void:
	character_image.texture = new_guy_text_sprite
	#set_text("")
	#set_cell_border_color(Color(0, 0, 0, 1))
	#text_label.visible_characters = 0
#[todo]: add in a way so that the timer doesn't end and subsequentially make a textbox that just appeared, disapear

func _process(delta: float) -> void:
	displayFor -= delta
	print(text_label.global_position.y)
	#if (displayFor <= 0):
		#global_position.y = -20
		#text_label.visible_characters = 0
		#hide_textbox()

func change_text_image(character):
	if (character == 1):
		character_image.texture = new_guy_text_sprite
	elif (character == 2):
		character_image.texture = swagula_text_sprite

func fusebox_activated():
	text_label.text = "Heard something deactivate from the left room, what is it now?"
	text_input = "Heard something deactivate from the left room, what is it now?"
	#text_label.visible_characters = 0
	show_textbox()
	displayFor = 4
	type_text()
	
func set_text(func_text_input: String):
	text_label.text = func_text_input
	text_input = func_text_input
	#text_label.visible_characters = 0
	show_textbox()
	displayFor = 4
	type_text()
#func gate_death():
	#set_text("Why'd we greenlight the electric gate again?")
	#visible_characters = 0
	#displayFor = 1.6
#
#func avoided_puddle():
	#set_text("Don't imagine stepping in that electrified puddle is a good idea.")
	#visible_characters = 0
	#displayFor = 1.75

func show_textbox():
	text_displayed = true
	var tween = create_tween()
	tween.tween_property(self, "global_position", text_label.global_position + Vector2(-text_label.global_position.x,185.0), .8)
	await get_tree().create_timer(6).timeout
	hide_textbox()

func hide_textbox():
	var tween = create_tween()
	tween.tween_property(self, "global_position",  text_label.global_position + Vector2(-text_label.global_position.x,-35.0), .8)

#Type_text function repurposed from spencer's code from StoryIntro
func type_text() -> void:
	var chars_per_second = 25.0
	var delay = 1.0 / chars_per_second

	for i in range(text_input.length()):
		text_label.visible_characters = i + 1
		await get_tree().create_timer(delay).timeout

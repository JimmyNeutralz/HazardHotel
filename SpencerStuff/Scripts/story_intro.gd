extends CanvasLayer

#Connections
@export var next_scene_path := "res://SpencerStuff/Scenes/BetaAutoMoveCopy.tscn"
@onready var label: Label = $IntroLabel

#Text to display
var full_text := """In Hazard Hotel, you solo play as a hired electrician at an infamous
monster-infested hotel. You've sent in your own new hire to navigate
through the building, while you stay behind with your trusty node box to
help him solve puzzles by accessing things through electrical currents.
To hopefully survive and — even more than that — hopefully repair
the Hazard Hotel!"""

var skip_pressed = false

func _ready() -> void:
	label.text = ""
	var skip_button = $SkipButton
	skip_button.pressed.connect(_on_skip_pressed)
	await type_text()
	if not skip_pressed:
		get_tree().change_scene_to_file(next_scene_path)

func type_text() -> void:
	var chars_per_second = 25.0
	var delay = 1.0 / chars_per_second
	for i in range(full_text.length()):
		if skip_pressed:  #Stop typing early
			return
		label.text = full_text.substr(0, i + 1)
		await get_tree().create_timer(delay).timeout

func _on_skip_pressed():
	skip_pressed = true
	get_tree().change_scene_to_file(next_scene_path)

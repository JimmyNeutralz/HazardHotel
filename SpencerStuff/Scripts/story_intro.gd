extends CanvasLayer

#Connections
@export var next_scene_path := "res://SpencerStuff/Scenes/AlphaAutoMoveCopy.tscn"
@onready var label: Label = $IntroLabel

#Text to display
var full_text := """In Hazard Hotel, you solo play as a hired electrician at an infamous
monster-infested hotel. You've sent in your own new hire to navigate
through the building, while you stay behind with your trusty node box to
help him solve puzzles by accessing things through electrical currents.
To hopefully survive and — even more than that — hopefully repair
the Hazard Hotel!"""

func _ready() -> void:
	label.text = ""
	#Call the typewriter function and wait for it to finish
	await type_text()
	#Switch scene after text finishes
	get_tree().change_scene_to_file(next_scene_path)

#Get text to type
func type_text() -> void:
	var chars_per_second = 25.0
	var delay = 1.0 / chars_per_second
	for i in range(full_text.length()):
		label.text = full_text.substr(0, i + 1)
		await get_tree().create_timer(delay).timeout

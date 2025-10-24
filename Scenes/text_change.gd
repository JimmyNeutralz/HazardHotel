extends RichTextLabel

func _ready() -> void:
	set_text("")

#Function that displays text when new guy hits the puddle colider and the puddle is electrified
func avoided_puddle():
	set_text("Woah! That puddle is electrified!")
	await get_tree().create_timer(1.5).timeout
	set_text("")
	
#Function that displays text when the electrified gate gets locked as new guy tries to open it
func gate_locked():
	set_text("... Did you lock the gate right as I was about to open it?")
	await get_tree().create_timer(1.5).timeout
	set_text("")

#Function that displays text after the player respawns after dying to the electrified gate
func gate_death():
	set_text("That gate was electrified? Seems like an obvious hazard in this hotel.")
	await get_tree().create_timer(1.5).timeout
	set_text("")

#Function that displays text after the player respawns after dying to the electrified puddle
func puddle_death():
	set_text("Wasn't that puddle safe just a second ago?")
	await get_tree().create_timer(1.5).timeout
	set_text("")

func completed_fusebox():
	set_text("This fusebox is already completed. No need to complete it again.")
	await get_tree().create_timer(1.5).timeout
	set_text("")

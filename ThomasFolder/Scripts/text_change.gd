extends RichTextLabel

func _ready() -> void:
	set_text("")
#[todo]: add in a way so that the timer doesn't end and subsequentially make a textbox that just appeared, disapear

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

#Function that displays text after the new guy tries to solve a completed fuse box
func completed_fusebox():
	set_text("This fusebox is already completed. No need to complete it again.")
	await get_tree().create_timer(1.5).timeout
	set_text("")

#Function that displays text after the new guy tries to interact with a fuse box
func missing_fuses():
	set_text("Don't have any fuses I can use with this fuse box.")
	await get_tree().create_timer(1.5).timeout
	set_text("")
	
#Function that displays text after the new guy picks up the fuse from the ground
func got_fuse():
	set_text("Not sure why these are here, but at least I can use these with the fuse box.")
	await get_tree().create_timer(1.5).timeout
	set_text("")

#Function that displays text after the new guy uses the dino grabber to get the fuse up on the shelf
func got_shelf_fuse():
	set_text("I'm not paid enough to question why the dino grabber was in the safe, but I got another fuse.")
	await get_tree().create_timer(1.75).timeout
	set_text("")

#Function that displays text after the new guy gets the dino grabber from the safe
func got_dino_grabber():
	set_text("A dino grabber in the safe? Oh! Perfect!")
	await get_tree().create_timer(1.5).timeout
	set_text("")
	
func inspect_empty_safe():
	set_text("The safe seems to be tragically empty...")
	await get_tree().create_timer(1.5).timeout
	set_text("")

extends RichTextLabel

var displayFor = 0

func _ready() -> void:
	set_text("")
	set_cell_border_color(Color(0, 0, 0, 1))
#[todo]: add in a way so that the timer doesn't end and subsequentially make a textbox that just appeared, disapear

func _process(delta: float) -> void:
	displayFor -= delta
	if (displayFor <= 0):
		set_text("")

func fusebox_activated():
	set_text("Heard something deactivate, from the left room, what is it now?")
	displayFor = 1.75
	
func gate_death():
	set_text("Why'd we greenlight the electric gate again?")
	displayFor = 1.6

func avoided_puddle():
	set_text("Don't imagine stepping in that electrified puddle is a good idea.")
	displayFor = 1.75

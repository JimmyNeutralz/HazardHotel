extends Node3D

#Node paths
@onready var area = $PuddleTrigger
@onready var indicator = $"../Indicators/PuddleIndicator"

@onready var puddle_colider = $"../PuddleColider"

#State
var puddle_active = true

func _ready():
	#Connect the trigger
	area.body_entered.connect(_on_body_entered)
	#Ensure indicator material is unique
	make_indicator_material_unique()
	update_indicator_color()

func _process(delta):
	#Handle puddle deactivation input
	if Input.is_action_just_pressed("deactivate_puddle") and puddle_active:
		deactivate()
		puddle_colider.change_puddle_colider_status(puddle_active)

func deactivate():
	puddle_active = false
	update_indicator_color()
	print("Puddle deactivated!")

#Trigger logic: kills the player every time if puddle is active
func _on_body_entered(body):
	if not puddle_active:
		return

	if body.name == "Player":
		kill_player(body)

func kill_player(player):
	print("Player killed by puddle!")
	$PuddleAudio.play()
	player.kill_player()  #Call player death function

#Indicator Helpers
func make_indicator_material_unique():
	if indicator == null:
		return
	var mat = indicator.get_active_material(0)
	if mat:
		var unique_mat = mat.duplicate()
		indicator.set_surface_override_material(0, unique_mat)
	else:
		indicator.set_surface_override_material(0, StandardMaterial3D.new())

func update_indicator_color():
	if indicator == null:
		return
	var mat = indicator.get_active_material(0)
	if mat == null:
		mat = StandardMaterial3D.new()
		indicator.set_surface_override_material(0, mat)

	if puddle_active:
		mat.albedo_color = Color.GREEN  # Activated / dangerous
	else:
		mat.albedo_color = Color.RED    # Deactivated / safe

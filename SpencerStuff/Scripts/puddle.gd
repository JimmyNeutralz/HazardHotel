extends Node3D

#get the area3d and indicator
@onready var area = $PuddleTrigger
@onready var indicator = $"../Indicators/PuddleIndicator"

var puddle_active = true
var player_dead = false

func _ready():
	area.body_entered.connect(_on_body_entered)
	make_indicator_material_unique()
	update_indicator_color()

#read for deactivate puddle (p)
func _process(delta):
	if Input.is_action_just_pressed("deactivate_puddle") and puddle_active and not player_dead:
		deactivate()

func deactivate():
	puddle_active = false
	#Change the puddle indicator
	update_indicator_color()
	#Notify user through console
	print("Puddle deactivated!")

func _on_body_entered(body):
	if not puddle_active:
		return

	if body.name == "Player":
		kill_player(body)

#kill player 
func kill_player(player):
	player_dead = true
	print("Player killed by puddle!")
	player.queue_free()
	
func make_indicator_material_unique():
	#Ensures the indicator uses its own copy of the material and doesn't change all of them
	var mat = indicator.get_active_material(0)
	if mat:
		var unique_mat = mat.duplicate()
		indicator.set_surface_override_material(0, unique_mat)
	else:
		indicator.set_surface_override_material(0, StandardMaterial3D.new())
	
#function to update PuddleIndicator color from red to green
func update_indicator_color():
	var mat = indicator.get_active_material(0)
	if mat == null:
		mat = StandardMaterial3D.new()
		indicator.set_surface_override_material(0, mat)

	if puddle_active:
		mat.albedo_color = Color.GREEN #activated
	else:
		mat.albedo_color = Color.RED #inactive

extends Node3D

#Path
@onready var indicator = $"../Indicators/FuseboxIndicator"
@export var puddle_node_path : NodePath  
var puddle : Node = null

var activated = false

func _ready():
	# Get the puddle node reference
	if puddle_node_path != null:
		puddle = get_node(puddle_node_path)
	else:
		push_error("Puddle node path not set for Fusebox!")

	make_indicator_material_unique()
	update_indicator_color()

func _process(delta):
	if Input.is_action_just_pressed("activate_fusebox") and not activated:
		if can_activate():
			activate()
		else:
			print("Cannot activate fusebox yet!")

#if player alive and puddle deactivated
func can_activate() -> bool:
	if puddle == null:
		return false

	#access the puddle variables
	var puddle_active = puddle.get("puddle_active")
	var player_dead = puddle.get("player_dead")

	if puddle_active:
		return false  #puddle not deactivated yet
	if player_dead:
		return false  #player is dead

	return true


func activate():
	activated = true
	update_indicator_color()
	print("Fusebox turned off!")
	print("Electric gate deactivated!")

#make sure all indicator colors dont change
func make_indicator_material_unique():
	var mat = indicator.get_active_material(0)
	if mat:
		var unique_mat = mat.duplicate()
		indicator.set_surface_override_material(0, unique_mat)
	else:
		indicator.set_surface_override_material(0, StandardMaterial3D.new())

func update_indicator_color():
	var mat = indicator.get_active_material(0)
	if mat == null:
		mat = StandardMaterial3D.new()
		indicator.set_surface_override_material(0, mat)

	if activated:
		mat.albedo_color = Color.RED    #activated
	else:
		mat.albedo_color = Color.GREEN  #inactive
		
	#Switched the color logic bc the fusebox should start on to initially power the electric gate, then 
	# be turned off by player so they can safely raise gate

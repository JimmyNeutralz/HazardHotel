extends Node3D

#Node paths

@onready var upperSafeLoc = $UpperSafe
@onready var originSafeLoc = $SafeOrigin
@onready var fuse = $HH_Art_Fuse2_V1
@onready var standSpot = $"../SafeLoc"

var realLoc
var fuseDropSpot

#State
var safe_raised = false
var has_slammed = false

func _ready():
	realLoc = originSafeLoc.global_position
	fuseDropSpot = standSpot.global_position

func _process(delta):
	#Handle safe deactivation input 
	if Input.is_action_just_pressed("raise_safe") and !safe_raised:
		raise_safe()
	if Input.is_action_just_pressed("lower_safe") and safe_raised:
		lower_safe()
	if has_slammed:
		pass

func raise_safe():
	var tween = create_tween()
	tween.tween_property(self, "global_position", upperSafeLoc.global_position, 1.0)
	#update_indicator_color()
	await tween.finished
	tween.kill()
	print("Safe Raised!")
	safe_raised = true


func lower_safe():
	var tween = create_tween()
	tween.tween_property(self, "global_position", realLoc, 0.5)
	#update_indicator_color()
	await tween.finished
	tween.kill()
	print("Safe Lowered!")
	
	var tween2 = create_tween()
	tween2.tween_property(fuse, "global_position", fuseDropSpot, 1.0)
	
	await tween2.finished
	tween2.kill()
	safe_raised = false
	has_slammed = true




##Indicator Helpers
#func make_indicator_material_unique():
	#if indicator == null:
		#return
	#var mat = indicator.get_active_material(0)
	#if mat:
		#var unique_mat = mat.duplicate()
		#indicator.set_surface_override_material(0, unique_mat)
	#else:
		#indicator.set_surface_override_material(0, StandardMaterial3D.new())
#
#func update_indicator_color():
	#if indicator == null:
		#return
	#var mat = indicator.get_active_material(0)
	#if mat == null:
		#mat = StandardMaterial3D.new()
		#indicator.set_surface_override_material(0, mat)
#
	#if puddle_active:
		#mat.albedo_color = Color.GREEN  # Activated / dangerous
	#else:
		#mat.albedo_color = Color.RED    # Deactivated / safe

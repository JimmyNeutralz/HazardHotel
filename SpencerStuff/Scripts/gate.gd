extends Node3D

#node paths
@onready var sprite = $Sprite3D
@onready var collision = $StaticBody3D/CollisionShape3D

#needs path of fusebox indicator to check color
@export var fusebox_indicator_path : NodePath  
var fusebox_indicator : MeshInstance3D = null

var raised = false

func _ready():
	if fusebox_indicator_path != null:
		fusebox_indicator = get_node(fusebox_indicator_path)
	else:
		push_error("FuseboxIndicator path not set for Gate!")

func _process(delta):
	if Input.is_action_just_pressed("raise_gate") and not raised:
		if can_raise():
			raise_gate()
		else:
			print("Cannot raise gate yet!")

func can_raise() -> bool:
	if fusebox_indicator == null:
		return false

	var mat = fusebox_indicator.get_active_material(0)
	if mat == null:
		return false

	#check if the fusebox indicator is green (fusebox active)
	if mat.albedo_color == Color.GREEN:
		return true
	return false

func raise_gate():
	raised = true

	#hide visual
	if sprite:
		sprite.visible = false

	#disable collision
	if collision:
		collision.disabled = true

	print("Gate raised!")

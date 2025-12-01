extends Sprite3D

@export var Vase:Node
@export var Player:Node
@export var RightRoom:Node
@export var MainRoom:Node
@export var Hole1:Node
@export var Hole2:Node
@export var Trap:Node
@export var Curtain:Node
@export var Mousewheel:Node
@export var WheelArea:Node
@export var GateIndicator:Node
var state
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	state = "Hole1"
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if(state == "Hole1"):
		global_position = Hole1.global_position + Vector3(0,0, 0.1)
		if(Vase.state == "shattered" and RightRoom==Player.get_current_room()):
			state = "Hole2"
			Player.move_to_object(Hole1)
	if(state == "Hole2"):
		global_position = Hole2.global_position + Vector3(0,0, 0.1)
		if(MainRoom==Player.get_current_room()):
			if(Curtain.state == "down" and Trap.state == "set"):
				state = "trapped"
				Trap.state = "triggered"
				Trap.rotation_degrees = Vector3(Trap.rotation_degrees.x,Trap.rotation_degrees.y,Trap.rotation_degrees.z-24)
	if(state == "trapped"):
		global_position = Trap.global_position
		if(Trap.state == "used"):
			state = "held"
	if(state == "held"):
		global_position = Player.global_position + Vector3(0,0, 1)
		if(Input.is_action_just_pressed("mousewheel")):
			Player.move_to_object(WheelArea)
		if(WheelArea.overlaps_body(Player)):
			state ="wheel"
				
	if(state == "wheel"):
		global_position = Mousewheel.global_position
		
		update_indicator_color()
	Mousewheel.rotation_degrees = Vector3(Mousewheel.rotation_degrees.x+1022,Mousewheel.rotation_degrees.y,Mousewheel.rotation_degrees.z)
	
func update_indicator_color():
	var mat = GateIndicator.get_active_material(0)
	if mat == null:
		mat = StandardMaterial3D.new()
		GateIndicator.set_surface_override_material(0, mat)
	if state == "wheel":
		mat.albedo_color = Color.RED
	else:
		mat.albedo_color = Color.GREEN
		

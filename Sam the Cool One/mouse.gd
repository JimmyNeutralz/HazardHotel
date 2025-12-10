extends AnimatedSprite3D

@export var Vase:Node
@export var Player:Node
@export var RightRoom:Node
@export var MainRoom:Node
@export var Hole1:Node
@export var Hole2:Node
@onready var Trap = $"../../Trap"
@onready var TrapAnim = $"../../Trap/TrapModel/AnimationPlayer"
@export var Curtain:Node
@onready var Mousewheel = $"../../MouseWheelDesk/Mousewheel/wheel/pCylinder2"
@onready var WheelAnim = $"../../MouseWheelDesk/Mousewheel/AnimationPlayer"
@onready var text = $"../../Overlay/TextPopup"
@export var WheelArea:Node
@export var FuseIndicator:Node
var state
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	state = "Hole1"
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if(Input.is_action_pressed("ui_end")):
		state = "wheel"
	if(state == "Hole1"):
		global_position = Hole1.global_position + Vector3(0,-0.2, 0.1)
		if(Vase.state == "shattered" and RightRoom==Player.get_current_room()):
			state = "Hole2"
			Player.move_to_object(Hole1)
			await get_tree().create_timer(0.2).timeout
			Player.crouching_player_interact()
			await get_tree().create_timer(1).timeout
			Player.crouching_interact_start = false
		play("idle")
	if(state == "Hole2"):
		global_position = Hole2.global_position + Vector3(0,-0.2, 0.1)
		if(MainRoom==Player.get_current_room()):
			if(Curtain.state == "closing" and Curtain.playdirection == "backward" and !Curtain.animator.is_playing() and Trap.state == "set"):
				state = "trapped"
				TrapAnim.play("Take 001")
				Trap.state = "triggered"
			play("idle")
	if(state == "trapped"):
		global_position = Trap.global_position
		if(Trap.state == "used"):
			state = "held"
			await get_tree().create_timer(0.2).timeout
			Player.crouching_player_interact()
			await get_tree().create_timer(1).timeout
			Player.crouching_interact_start =false
			text.set_text("Gotcha, you little rodent. You're coming with me.", 6)
	if(state == "held"):
		global_position = Player.global_position + Vector3(0,0, -100)
		if(WheelArea.overlaps_body(Player)):
			state ="wheel"
				
	if(state == "wheel"):
		global_position = Mousewheel.global_position - Vector3(0,0.1,0)
		play("RUN")
		WheelAnim.play_section("Take 001", 0.0, 4.1667, -1, -0.5, true)
		update_indicator_color()
	
	
func update_indicator_color():
	var mat = FuseIndicator.get_active_material(0)
	if mat == null:
		mat = StandardMaterial3D.new()
		FuseIndicator.set_surface_override_material(0, mat)
	if state == "wheel":
		mat.albedo_color = Color.GREEN
	else:
		mat.albedo_color = Color.RED
		

extends Node3D

@onready var Detect = $Area3D
@export var Player:Node
@export var Cheese:Node
@onready var UI = $TrapUI
var state
signal PlayerNextToTrap
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	state = "start"
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if(Cheese.state == "held" or state == "triggered"):
		UI.visible =true
	else:
		UI.visible = false
	if(Input.is_action_just_pressed("trap") and state == "start"):
		Player.move_to_object(self)
		await PlayerNextToTrap
		if(Cheese.state == "held"):
			Cheese.use(self)
			state = "set"
			await get_tree().create_timer(0.2).timeout
			Player.crouching_player_interact()
			await get_tree().create_timer(1).timeout
			Player.crouching_interact_start =false
		else:
			#Say Something About nothing to bait mouse
			pass
	if(state == "triggered"):
		Cheese.state = "eaten"
		if(Input.is_action_just_pressed("trap")):
			Player.move_to_object(self)
			await PlayerNextToTrap
			state = "used"
		


func _on_area_3d_body_entered(body: Node3D) -> void:
	if(body == Player):
		emit_signal("PlayerNextToTrap")

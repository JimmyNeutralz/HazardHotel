extends Node3D

var state
var playdirection = "forward"
@export var Player:Node
@onready var curtain = $HH_Art_Curtain_V2
@onready var animator:AnimationPlayer = $HH_Art_Curtain_V2/AnimationPlayer
signal gotocurtain
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	animator.play_section("Take 001", 2.0, 2.01)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	toggle_curtain()
	if(state == "opening" and !animator.is_playing() and playdirection != "forward"):
		animator.play_section("Take 001", 0.0, 2.01)
		playdirection = "forward"
	if(state == "closing" and !animator.is_playing() and playdirection != "backward"):
		animator.play_section_backwards("Take 001", 0.0, 2.01)
		playdirection = "backward"

func toggle_curtain():
	if Input.is_action_pressed("toggle_curtain"):
		if state != "closing":
			Player.move_to_object($Area3D)
			if(!$Area3D.overlaps_body(Player)):
				await(gotocurtain)
			state = "closing"
		else:
			return
	else:
		state = "opening"


func _on_area_3d_body_entered(body: Node3D) -> void:
	if(body == Player):
		emit_signal("gotocurtain")

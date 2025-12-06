extends Node3D

@export var Mouse:Node
@export var Player:Node
var Detector
var state
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Detector = $Area3D
	state = "ground"
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if(Mouse.state == "Hole2" and Detector.overlaps_body(Player)):
		state = "held"
	if(state == "held"):
		global_position = Player.global_position + Vector3(0,0,1)
	if(state == "used"):
		visible = false

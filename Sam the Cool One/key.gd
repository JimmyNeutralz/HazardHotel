extends Node3D

@export var Mouse:Node
@export var Player:Node
@onready var Vase = $"../../Vase"
var Detector
var state
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Detector = $Area3D
	state = "pot"
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if(state == "pot"):
		visible = false
		if(Vase.state == "shattered"):
			visible = true
			state = "ground"
	if(state == "ground" and Mouse.state == "Hole2" and Detector.overlaps_body(Player)):
		state = "held"
	if(state == "held"):
		global_position = Player.global_position + Vector3(0,0,-100)
	if(state == "used"):
		visible = false

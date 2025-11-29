extends Sprite3D

@export var Vase:Node
var state
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	state = "Hole1"
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if(state == "Hole1" and Vase.state == "shattered"):
		print("amongus")
		pass

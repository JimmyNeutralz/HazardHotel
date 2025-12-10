extends Node3D

var state
var followobj:Node3D
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	state = "lockedup"
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if(state == "held"):
		self.global_position = followobj.global_position+ Vector3(0,0,-100)
	if(state == "eaten"):
		visible =false
	
func grab(player:Node3D):
	state = "held"
	followobj = player
	
func use(object:Node3D):
	state = "trap"
	self.global_position = object.global_position + Vector3(0.2,0,0)

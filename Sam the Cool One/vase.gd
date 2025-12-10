extends Node3D

@export var Vent:Node
@onready var Vase = $Vase
@onready var VaseTexture = $Vase/CollisionShape3D/MeshInstance3D
@onready var ShatterArea = $ShatteringArea
@onready var Shards = $VaseShards
var state
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	state = "still"
	if(Vent.active ==null):
		print("Dude set the node for the vase object to the vent object or this wont work.")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if(_VentOn() and state == "still"):
		state = "falling"
		Vase.linear_velocity.x = Vector3((Vase.global_position-ShatterArea.global_position).normalized()).x
		print(Vase.linear_velocity)
	if(state == "falling"):
		Vase.gravity_scale = 1
	else:
		Vase.gravity_scale = 0
	if(state == "shattered"):
		Vase.linear_velocity = Vector3.ZERO
		Vase.angular_velocity = Vector3.ZERO
		Shards.global_position = ShatterArea.global_position
		Vase.visible = false
		Shards.visible = true
	
	
func _VentOn():
	if(Vent.active == true):
		return true
	else:
		return false


func _on_shattering_area_body_entered(body: Node3D) -> void:
	if(body == Vase and state == "falling"):
		state = "shattered"

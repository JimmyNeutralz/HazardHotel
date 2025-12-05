extends Node3D

var state
@export var Player:Node
@onready var Up = $Up
@onready var Down = $Down
signal gotocurtain
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	state = "up"
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if(state == "up"):
		Up.visible = true
		Down.visible = false
	if(state == "down"):
		Up.visible = false
		Down.visible = true
	toggle_curtain()

func toggle_curtain():
	if Input.is_action_just_pressed("toggle_curtain"):
		Player.move_to_object($Area3D)
		if(!$Area3D.overlaps_body(Player)):
			await(gotocurtain)
		state = "down"
	elif(Input.is_action_pressed("toggle_curtain")):
		return
	else:
		state = "up"


func _on_area_3d_body_entered(body: Node3D) -> void:
	if(body == Player):
		emit_signal("gotocurtain")

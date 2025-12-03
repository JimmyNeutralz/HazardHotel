extends Node3D

@export var Player:Node
@export var Key:Node
@export var Cheese:Node
@onready var detector = $FrontofSafe
var state
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	state = "closed" # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_pressed("open_safe2"):
		if(Key.state == "held"):
			Player.move_to_object(self)
			state = "open"
		else:
			Player.move_to_object(self)
			print("No Key")
	if(detector.overlaps_body(Player) and state == "open"):
		Cheese.grab(Player)
		Key.state = "used"

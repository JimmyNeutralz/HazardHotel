extends Node3D

@export var Player:Node
@export var Key:Node
@export var Cheese:Node
@onready var detector = $FrontofSafe
var state
var anim_player:AnimationPlayer = null
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	anim_player = find_animation_player($HH_Art_SafeAnim_V3)
	state = "closed" # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_pressed("open_safe2"):
		if(Key.state == "held"):
			open_safe()
		else:
			Player.move_to_object(self)
			print("No Key")
	if(state == "open"):
		Player.move_to_object(self)
		if(detector.overlaps_body(Player)):
			Cheese.grab(Player)
			Key.state = "used"
			state = "item_obtained"
			Player.move_to_object(Player)
			Player.play_stand_interact()
		
func open_safe():
	if anim_player and anim_player.has_animation("Take 001"):
		anim_player.play("Take 001")
		await get_tree().create_timer(1.5).timeout
		print("Safe open!")
		state = "open"

		
func find_animation_player(node: Node) -> AnimationPlayer:
	if node is AnimationPlayer:
		return node
	for child in node.get_children():
		var found = find_animation_player(child)
		if found:
			return found
	return null

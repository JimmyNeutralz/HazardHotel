extends Area2D

var electrified = true
var open = false

@onready var player = load("res://Scenes/auto_movement_player.tscn")

func _process(delta):
	electrified = get_parent().isEletrified
	open = get_parent().isOpened
	if (!electrified && open):
		$Sprite2D.modulate = Color(0.0, 0.246, 0.061, 1.0)
		
	elif (!electrified && !open):
		$Sprite2D.modulate = Color(0.0, 0.725, 0.246, 1.0)
	elif (open):
		$Sprite2D.modulate = Color(0.162, 0.162, 0.162, 1.0)
	else:
		$Sprite2D.modulate = Color(0.725, 0.725, 0.725, 1.0)
	
func _on_body_entered(body: Node2D) -> void:
	if (electrified):
		get_tree().call_group("Player", "_die")
		

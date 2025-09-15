extends Area2D

var isDeadly = false
@onready var player = load("res://Scenes/test_player.tscn")


func _process(delta):
	isDeadly = get_parent().isConnected
	if (!isDeadly):
		$Sprite2D.modulate = Color(1, 1, 1)
		
	else:
		$Sprite2D.modulate = Color(0, 0, 0)
	
#func _on_area_entered(area: Area2D) -> void:
	#if (isDeadly):
		#print("you die!")

func _on_body_entered(body: Node2D) -> void:
	if (isDeadly):
		get_tree().call_group("Player", "_die")
		

extends Area2D

var isLowered = false
@onready var player = load("res://Scenes/dumbWaiter.tscn")


func _process(delta):
	isLowered = get_parent().isConnected
	if (!isLowered):
		$Sprite.modulate = Color(1, 1, 1)
		pass
		
	else:
		$Sprite.modulate = Color(0, 0, 0)
		pass
	
#func _on_area_entered(area: Area2D) -> void:
	#if (isDeadly):
		#print("you die!")

func _on_body_entered(body: Node2D) -> void:
	if (isLowered):
		get_tree().call_group("Player", "_get_key")

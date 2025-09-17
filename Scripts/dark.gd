extends Sprite2D


var isDark = true
#@onready var player = $Player
@onready var darkBox = $DarkArea/CollisionShape2D

func _start():
	darkBox.disabled = false


func _on_dark_area_area_entered(area: Area2D) -> void:
	#if (isDark and .is_in_group("Player")):
		#get_tree().call_group("Player", "_reverse")
	pass

extends Sprite2D

var isDark = true

func _process(delta):
	isDark = get_parent().isConnected
	if (!isDark):
		get_node("Dark").hide()
		
	else:
		get_node("Dark").hide()

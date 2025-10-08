extends Button

func _process(_delta: float) -> void:
	if(MainDataStorageTest.isRed8Connected):
		get_node("RedLight").modulate = Color(0.957, 0.0, 0.0, 1.0)
	else:
		get_node("RedLight").modulate = Color(0.985, 0.86, 0.92, 1.0)

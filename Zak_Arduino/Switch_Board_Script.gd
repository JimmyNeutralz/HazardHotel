extends Node2D

var switchJacks = []
var secondlist = []

var Hole_Temp = preload("res://Zak_Arduino/Switch_Jack.tscn")

func _ready() -> void:
	for i in range(3):
		switchJacks.append([])
		for j in range(3):
			switchJacks[i].append(0)
	
	spawn()
	var temp = ""
	
	for i in range(3):
		for j in range(3):
			temp += str(switchJacks[i][j])
		temp += "\n"
	
	print(temp)

func spawn() -> void:
	print("test")
	var jack = Hole_Temp.instantiate()
	add_child(jack)
	jack.SwitchJack(Color.PURPLE, Color.BLUE)

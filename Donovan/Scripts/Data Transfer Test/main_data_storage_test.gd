extends Node2D

var points = 0
var isRed8Connected = false


func _increasePoints():
	points += 1
	print("Current Points: ", points)
func _printScore():
	print("Current Points: ", points)


func _toggleRed8():
	if(isRed8Connected):
		isRed8Connected = false
	else:
		isRed8Connected = true

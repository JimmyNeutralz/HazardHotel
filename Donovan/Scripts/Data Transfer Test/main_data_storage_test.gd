extends Node2D

var points = 0


func _increasePoints():
	points += 1
	print("Current Points: ", points)
func _printScore():
	print("Current Points: ", points)

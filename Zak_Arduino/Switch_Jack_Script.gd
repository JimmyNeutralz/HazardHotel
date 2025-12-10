extends Node2D

var rect
var jackColorOn
var jackColorOff
var wire
var connectedJackX
var connectedJackY

func _ready() -> void:
	rect = $ColorRect
	print("READY: rect =", rect)
	jackColorOn = Color.RED
	jackColorOff = Color.BLUE

func SwitchJack(cOn, cOff):
	jackColorOn = cOn
	jackColorOff = cOff
	rect.color = Color(jackColorOff)

func _on_button_button_down() -> void:
	rect.color = jackColorOn

func _on_button_button_up() -> void:
	rect.color = jackColorOff

extends Control


# These are the various callable functions that relate back to the
# functions in the MainDataStorageTest globally loaded object
var callable = Callable(MainDataStorageTest, "_increasePoints")
var callable2 = Callable(MainDataStorageTest, "_printScore")


# Prints score when loading into scene
func _ready():
	callable2.call()

# Scene transition
func _on_button_pressed():
	Global.goto_scene("res://Donovan/Scenes/scene_1.tscn")

# Point increasing button
func _on_button_2_pressed() -> void:
	callable.call()

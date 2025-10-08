extends Node3D

#file paths
@onready var lock_visual = $LeftLock
@onready var blocker = $LeftArea

var locked: bool = true

func _ready() -> void:
	lock_visual.visible = locked
	blocker.visible = locked  #for seeing in-editor

#unlock
func _process(_delta: float) -> void:
	if locked and Input.is_action_just_pressed("unlock_left"):
		unlock_door()

func unlock_door() -> void:
	locked = false
	lock_visual.visible = false
	blocker.queue_free()  #Removes the StaticBody so player can walk through
	print("Left door unlocked!")

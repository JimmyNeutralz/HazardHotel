extends Node3D

#node paths
@onready var elevator_lock = $Elevator/ElevatorLock
#generator indicator = condition for floor completed
@onready var generator_indicator = $Indicators/GeneratorIndicator  

var floor_completed = false

func _process(delta):
	if not floor_completed and is_generator_on():
		unlock_elevator()

func is_generator_on() -> bool:
	if generator_indicator == null:
		return false
	
	var mat = generator_indicator.get_active_material(0)
	if mat == null:
		return false

	#check if the indicator color is green (generator activated)
	return mat.albedo_color == Color.GREEN

func unlock_elevator():
	floor_completed = true

	if elevator_lock:
		elevator_lock.visible = false

	print("Elevator Unlocked. Floor Completed!")

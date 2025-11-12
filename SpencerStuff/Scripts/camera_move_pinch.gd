extends Camera3D

var target_position: Vector3
@export var move_time: float = 0.8  #How many seconds the pan takes

func _ready() -> void:
	target_position = global_position  #Start at current location (MainCamPos)

func pan_to(new_position: Vector3) -> void:
	target_position = new_position
	var tween = create_tween() #essentially lerp
	tween.tween_property(self, "global_position", target_position, move_time) #move

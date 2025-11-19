extends Camera3D

var target_position: Vector3
@export var move_time: float = 0.8  # How many seconds the pan takes

@onready var main_cam_pos = $"../MainCamPos"

func _ready() -> void:
	target_position = global_position  # Start at current location

func pan_to(new_position: Vector3) -> void:
	target_position = new_position
	var tween = create_tween()
	tween.tween_property(self, "global_position", target_position, move_time)

# --- New Function ---
func ResetCamera():
	if main_cam_pos:
		global_position = main_cam_pos.global_position
		print("Camera reset to main position.")
	else:
		push_error("MainCamPos not found for camera!")

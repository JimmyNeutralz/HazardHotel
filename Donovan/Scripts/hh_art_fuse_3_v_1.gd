extends Node3D

@onready var landing_zone = $"../Fuse3Landing"

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("lower_fuse_3"):
		lerp(self.global_position, landing_zone.global_position, 1)

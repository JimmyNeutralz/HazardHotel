extends CharacterBody3D

@export var speed: float = 5.0  #Movespeed

func _physics_process(delta: float) -> void:
	
	#Initially not moving
	var move_dir := 0.0

	#Cover left and right from input map
	if Input.is_action_pressed("left"):
		move_dir -= 1
	if Input.is_action_pressed("right"):
		move_dir += 1

	#Set velocity along X axis
	velocity.x = move_dir * speed

	#Apply movement (respects collisions)
	move_and_slide()

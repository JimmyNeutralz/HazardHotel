extends CharacterBody3D

@export var speed: float = 5.0  #Movespeed

func _process(delta: float) -> void:
	#Move direction initially 0 bc no input
	var move_dir := 0.0

	if Input.is_action_pressed("left"):
		move_dir -= 1
	if Input.is_action_pressed("right"):
		move_dir += 1

	#Move along the X axis at desired speed
	position.x += move_dir * speed * delta

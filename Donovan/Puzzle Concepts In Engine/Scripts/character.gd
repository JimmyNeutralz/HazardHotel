extends CharacterBody3D

# How fast the player moves in meters per second.
@export var speed = 5
# The downward acceleration when in the air, in meters per second squared.
@export var fall_acceleration = 75

var target_velocity = Vector3.ZERO
var MyCSharpScript = load("res://Donovan/Puzzle Concepts In Engine/Scripts/character.cs")
var my_csharp_node = MyCSharpScript.new()


func _physics_process(delta):
	var direction = Vector3.ZERO

	if Input.is_action_pressed("right"):
		direction.z += 1
	if Input.is_action_pressed("left"):
		direction.z -= 1

	# Ground Velocity
	target_velocity.x = direction.x * speed
	target_velocity.z = direction.z * speed

	# Vertical Velocity
	if not is_on_floor(): # If in the air, fall towards the floor. Literally gravity
		target_velocity.y = target_velocity.y - (fall_acceleration * delta)

	 #Moving the Character
	velocity = target_velocity
	move_and_slide()

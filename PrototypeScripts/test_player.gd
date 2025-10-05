extends CharacterBody2D

@export var speed = 400
@onready var hitBox = $CollisionShape2D
var hasKey = false

func start():
	hitBox.disabled = false
	
func get_input():
	var input_direction = Input.get_vector("left", "right", "up", "down")
	velocity = input_direction * speed
	
func _physics_process(delta):
	get_input()
	move_and_slide()
		
		
func _die():
	queue_free()
	print ("YOU DIED!")
	
func _get_key():
	if (hasKey == false):
		hasKey = true
		print("GOT KEY!")
		
func _has_key():
	return hasKey
	

	

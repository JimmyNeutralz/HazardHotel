extends CharacterBody2D

@export var speed = 400
@onready var hitBox = $CollisionShape2D
var hasKey = false
var moving = false 

func start():
	hitBox.disabled = false
	
	
#func get_input():
	#var input_direction = Input.get_vector("left", "right", "up", "down")
	#velocity = input_direction * speed
	
#func _physics_process(delta):
	#get_input()
	#move_and_slide()
		
		
func _die():
	queue_free()
	print ("YOU DIED!")
	
func _get_key():
	if (hasKey == false):
		hasKey = true
		print("GOT KEY!")
		
func _has_key():
	return hasKey
	

#Automatic movement that happens when the puddle is deactivated
func _move_to_right_door(delta):
	if (!moving):
		moving = true
		while (position != Vector2(1126,534)):
			#Copilot provided answer upon searching up code to do so
			global_position = global_position.move_toward(Vector2(1126,534), speed * delta)
			#Line of code below found on GDScript.com
			await get_tree().create_timer(0.001).timeout
		moving = false
	

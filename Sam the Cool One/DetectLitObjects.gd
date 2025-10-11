extends SpotLight3D


var spotlight3d = self
var multiplier
var detectarea
var detectshape
var shape  = CylinderShape3D.new()
var arr
var anglefromlight
var ray


# Called when the node enters the scene tree for the first time.
func _ready():
	multiplier = 0.0
	ray = get_node("RayCast3D")
	detectarea = get_node("Detection Area")
	detectshape = get_node("Detection Area/Detection Shape")
	spot_angle = 20.0
	pass # Replace with function body.

func toRadians(angle):
	return angle*(PI/180)
func toDegrees(angle):
	return angle*(180/PI)
# Called every frame. 'delta' is the elapsed time since the previous frame.

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("ui_accept"): 
		set_meta("fixed", !get_meta("fixed"))
	if Input.is_action_just_pressed("ui_focus_next"): 
		visible = !visible
	if(visible != true):
		return
	if get_meta("fixed") == false:
		multiplier += 1
		spot_angle = 40+(sin(toRadians(multiplier))*20)
		spot_attenuation = 3+(sin(toRadians(multiplier*1.2)))*1
		light_color = Color(1.0, 0.5+sin(toRadians(multiplier*1.5))*0.5, 0.5+sin(toRadians(multiplier*1.5))*0.5, 1.0)
	#if(spot_angle > 35 or spot_angle<10):
		#multiplier = 1/multiplier
		#spot_angle = spot_angle*multiplier
	shape.radius = (tan(toRadians(spot_angle/2)))*spot_range
	shape.height = spot_range
	detectshape.global_position = Vector3(detectshape.global_position.x,global_position.y-(shape.height/2),global_position.z)
	detectshape.set_shape(shape)
	arr = detectarea.get_overlapping_bodies()
	for i in range(len(arr)):
		if arr[i].has_meta("InLight"):
			anglefromlight = toDegrees(tanh(abs(arr[i].position.x - position.x)/abs(arr[i].position.y - position.y)))
			ray.global_position = arr[i].global_position
			ray.target_position = Vector3(global_position-ray.global_position)
			ray.collide_with_bodies = true
			if(anglefromlight < spot_angle and !ray.is_colliding()):
				arr[i].set_meta("InLight", true)
			#else:
				#arr[i].set_meta("InLight", false)
	#print(abs(tan(toRadians(spot_angle/2)))*(position.y - torus.position.y))
	#Check for all objects in the cone.
	#Draw Raycasts to each position and check if they are visible
	#If works



	 # Replace with function body.


#func _on_detection_area_body_exited(body: Node3D) -> void:
	#if body.has_meta("InLight"):
		#body.set_meta("InLight", false)

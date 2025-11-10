extends SpotLight3D

var multiplier = 0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func toRadians(angle):
	return angle*(PI/180)
func toDegrees(angle):
	return angle*(180/PI)
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	multiplier += 1
	light_energy = 0.5+sin(toRadians(multiplier))*0.1
	if(sin(toRadians(multiplier*3))>0.9 and sin(toRadians(multiplier*3))<0.92 and sin(toRadians(multiplier*0.2))>0.9):
		light_energy = 0.05
	pass

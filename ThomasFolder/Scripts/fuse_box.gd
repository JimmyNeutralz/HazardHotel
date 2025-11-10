extends Area3D
@onready var player = $"../3dPlayer"
@onready var fuseBoxUi = $"../Camera3D/FuseBoxUi"
@onready var text = $"../Camera3D/RichTextLabel"
var moving = false

func _process(delta: float) -> void:
	if (Input.is_action_just_pressed("Open Fuse Box")):
		player.move_to(global_position.x)
		moving = true


#func _on_area_entered(area: CharacterBody3D) -> void:
	#print("Colided!")
	#if (moving):
		#moving = false
		#player.reached_destination()


func _on_body_entered(body: Node3D) -> void:
	if (moving and fuseBoxUi.amountComplete <= 2 and (fuseBoxUi.fusesGathered >= 1)):
		moving = false
		player.reached_destination()
		fuseBoxUi.toggle_visibility(true)
		player.in_menu()
	elif(moving and fuseBoxUi.amountComplete >= 2):
		moving = false
		player.reached_destination()
		text.completed_fusebox()
	elif (moving and fuseBoxUi.fusesGathered < 1):
		moving = false
		player.reached_destination()
		text.missing_fuses()

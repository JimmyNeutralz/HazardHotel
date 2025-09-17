extends Node2D

var dark_active := true
var player_dead := false
var grate_active := true


#Press 8 to turn on lights
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("key_8") and dark_active:
		get_node("Dark/CollisionShape2DDark").disabled = true    # Disable collision
		var dark = $Dark
		dark.hide()
		dark_active = false
		print("Lights powered!")

	#Press 9 to raise the grate
	if Input.is_action_just_pressed("key_9") and not dark_active and grate_active:
		get_node("Grate/CollisionShape2DGrate").disabled = true    #Disable collision
		var grate = $Grate
		grate.hide()
		grate_active = false
		print("Grate raised!")


func _on_elevator_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		body.queue_free()
		print("Floor 1 Complete!") 

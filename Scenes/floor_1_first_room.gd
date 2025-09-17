extends Node2D

var wind_active := true
var player_dead := false
var cobweb_active := true

func _process(delta: float) -> void:
	if player_dead:
		return  #Stops checking input if player is dead

	#Press 3 to remove the wind hazard
	if Input.is_action_just_pressed("key_3") and wind_active:
		var wind1 = $Wind1
		wind1.hide()
		wind_active = false
		print("Wind removed!")

	#Press 7 to remove the cobweb (only if wind is gone)
	if Input.is_action_just_pressed("key_7") and not wind_active and cobweb_active:
		var cobweb = $Cobweb
		cobweb.hide()
		cobweb_active = false
		print("Cobweb removed!")


func _on_wind_1_body_entered(body: Node2D) -> void:
	if wind_active and body.name == "Player":
		player_dead = true
		body.queue_free()
		print("YOU DIED!")

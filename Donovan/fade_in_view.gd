extends Node3D
@onready var tvFuzz = $TVFuzz
@onready var trueTVFuzz = $Control


#Transitions a video of static from full visibility to none
func _fade_static_out():
	var tween = get_tree().create_tween()
	tween.tween_property(trueTVFuzz, "modulate", Color(1, 1, 1, 0), 1.5)
	await tween.finished
	tween.kill()
	
#Transitions a video of static from no visibility to full visibility
func _fade_static_in():
	var tween = get_tree().create_tween()
	tween.tween_property(trueTVFuzz, "modulate", Color(1, 1, 1, 1), 1.5)
	await tween.finished
	tween.kill()



#Uses _fade_static_out to smoothly transition to next scene
func _exit_scene(next_scene_path):
	var tween = get_tree().create_tween()
	tween.tween_property(trueTVFuzz, "modulate", Color(1, 1, 1, 1), 1.5)
	await tween.finished
	tween.kill()
	await get_tree().create_timer(0.5).timeout
	get_tree().change_scene_to_file(next_scene_path)

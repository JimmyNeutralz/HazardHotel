extends Node3D
@onready var tvFuzz = $TVFuzz
@onready var trueTVFuzz = $Control


func _fade_static_out():
	var tween = get_tree().create_tween()
	tween.tween_property(trueTVFuzz, "modulate", Color(1, 1, 1, 0), 1.5)
	await tween.finished
	tween.kill()
	
func _fade_static_in():
	var tween = get_tree().create_tween()
	tween.tween_property(trueTVFuzz, "modulate", Color(1, 1, 1, 1), 1.5)
	await tween.finished
	tween.kill()

func _exit_scene(next_scene_path):
	var tween = get_tree().create_tween()
	tween.tween_property(trueTVFuzz, "modulate", Color(1, 1, 1, 1), 1.5)
	await tween.finished
	await get_tree().create_timer(0.5).timeout
	get_tree().change_scene_to_file(next_scene_path)
	tween.kill()

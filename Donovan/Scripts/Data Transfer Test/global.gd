extends Node
@onready var trueTVFuzz = "res://Donovan/staticVideo.tscn"

var current_scene = null

func _ready():
	var root = get_tree().root
	current_scene = root.get_child(-1)

func goto_scene(path):
	deferred_goto_scene.call_deferred(path)

func deferred_goto_scene(path):
	
	current_scene.queue_free()
	var s = ResourceLoader.load(path)
	current_scene = s.instantiate()
	get_tree().root.add_child(current_scene)
	get_tree().current_scene = current_scene

func fade_to_level_2():
	var tween = get_tree().create_tween()
	tween.tween_property(trueTVFuzz, "modulate", Color(1, 1, 1, 1), 1.5)
	await tween.finished
	await get_tree().create_timer(0.5).timeout
	get_tree().change_scene_to_file("res://Donovan/MODIFIEDAlphaV4.tscn")
	tween.kill()

extends Node3D

var lock_anim: AnimationPlayer

func _ready():
	lock_anim = find_animation_player(self)
	if lock_anim and lock_anim.has_animation("Take 001"):
		lock_anim.seek(0.0, true)

func play_lock_animation() -> void:
	#Play lock anim and wait for it to finish
	if lock_anim and lock_anim.has_animation("Take 001"):
		lock_anim.play("Take 001")
		await get_tree().create_timer(lock_anim.current_animation_length).timeout
	

func find_animation_player(node: Node) -> AnimationPlayer:
	if node is AnimationPlayer:
		return node
	for child in node.get_children():
		var found = find_animation_player(child)
		if found:
			return found
	return null
	
func play_backwards_lock_animation() -> void:
	#Play lock anim and wait for it to finish
	if lock_anim and lock_anim.has_animation("Take 001"):
		lock_anim.play_backwards("Take 001")
		await get_tree().create_timer(lock_anim.current_animation_length).timeout

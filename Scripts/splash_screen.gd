extends Control



func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	ScenesManager.change_scene(ScenesManager.MAIN_MENU)

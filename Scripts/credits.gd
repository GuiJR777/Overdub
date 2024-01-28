extends Node2D



func _on_back_button_pressed() -> void:
	ScenesManager.change_scene(ScenesManager.MAIN_MENU)

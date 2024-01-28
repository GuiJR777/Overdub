extends Node2D

@onready var audio_stream_player: AudioStreamPlayer = %AudioStreamPlayer

var peer: ENetMultiplayerPeer



func start_music() -> void:
	audio_stream_player.play()


func _on_audio_stream_player_finished() -> void:
	audio_stream_player.play()


func _on_exit_button_pressed() -> void:
	get_tree().quit()


func _on_start_button_pressed() -> void:
	ScenesManager.change_scene(ScenesManager.JOIN_HOST_ROOM)

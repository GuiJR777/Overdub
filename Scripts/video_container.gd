extends VBoxContainer

@onready var card_spaces: HBoxContainer = %CardSpaces
@onready var video_stream_player: VideoPlayer = %VideoStreamPlayer


var card_space_scene: PackedScene = load("res://Scenes/card_space.tscn")



func _on_big_screen_finished() -> void:
	for second in int(video_stream_player.total_video_duration):
		var instance = card_space_scene.instantiate() as CardSpace
		instance.value = second
		card_spaces.add_child(instance)

extends Node2D


@export var video_path: String


@onready var big_screen: VideoPlayer = %BigScreen
@onready var video_stream_player: VideoPlayer = %VideoStreamPlayer
@onready var editor: HBoxContainer = %Editor
@onready var card_repository: GridContainer = %CardRepository

var card_scene: PackedScene = preload("res://Scenes/card.tscn")


func _ready() -> void:
	big_screen.total_video_duration = 0
	video_path = ResourcesManager.get_random_video_from_map()
	print(video_path)
	var video= load(video_path)
	big_screen.stream = video
	big_screen.start_video()


func spawn_random_sound_cards(amount: int):
	for index in range(amount):
		var card_instance = card_scene.instantiate() as AudioCard
		var random_sound = ResourcesManager.get_random_music_from_map()
		var sound = load(random_sound)
		card_instance.audio = sound
		card_instance.audio_name = random_sound.replace(".ogg", "").replace(".ogv", "").replace(".mp3","").replace(".wav","").replace(ResourcesManager.MUSICS_FOLDER_PATH, "")
		card_repository.add_child(card_instance)


func _on_big_screen_finished() -> void:
	video_stream_player.total_video_duration = big_screen.total_video_duration
	video_stream_player.stream = big_screen.stream
	big_screen.hide()
	editor.show()
	spawn_random_sound_cards(4)

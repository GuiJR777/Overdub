extends Node2D
class_name EditionRoom


@export var time_to_edit_in_seconds: int = 90

@onready var big_screen: VideoPlayer = %BigScreen
@onready var video_stream_player: VideoPlayer = %VideoStreamPlayer
@onready var editor: HBoxContainer = %Editor
@onready var card_repository: GridContainer = %CardRepository
@onready var time_progress: TextureProgressBar = %TimeProgress
@onready var card_spaces: HBoxContainer = %CardSpaces

signal finish_edition

var card_scene: PackedScene = preload("res://Scenes/card.tscn")
var rest_time: float
var player_reference: Player


func _ready() -> void:
	time_progress.max_value = time_to_edit_in_seconds
	time_progress.value = time_to_edit_in_seconds
	rest_time = float(time_to_edit_in_seconds)

func _process(delta: float) -> void:
	if not big_screen.visible:
		rest_time -= delta
		time_progress.value = rest_time

	if rest_time <= 0:
		edition_finish()


func start_video(video) -> void:
	if not video:
		get_tree().reload_current_scene()

	print("Video received!")
	big_screen.total_video_duration = 0

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



func edition_finish():
	print("Edição finalizada")
	player_reference.video_data["stream"] = video_stream_player.stream
	player_reference.video_data["audios_map"] = video_stream_player.audios_map
	player_reference.video_data["total_video_duration"] = video_stream_player.total_video_duration
	finish_edition.emit()


func _on_big_screen_finished() -> void:
	video_stream_player.total_video_duration = big_screen.total_video_duration
	video_stream_player.stream = big_screen.stream
	big_screen.hide()
	editor.show()
	spawn_random_sound_cards(4)


func _on_finish_button_pressed() -> void:
	edition_finish()

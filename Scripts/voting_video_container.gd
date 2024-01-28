extends VBoxContainer
class_name VotingContainer

@export var video_data: Dictionary
@export var player_nickname: String

@onready var player_nick_name_label: Label = $PlayerNickNameLabel
@onready var video_stream_player: VideoStreamPlayer = %VideoStreamPlayer



func setup() -> void:
	print(video_data)
	video_stream_player.stream = video_data.get("stream")
	video_stream_player.audios_map = video_data.get("audios_map")
	video_stream_player.total_video_duration = video_data.get("total_video_duration")
	player_nick_name_label.text = player_nickname

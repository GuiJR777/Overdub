extends VideoStreamPlayer
class_name VideoPlayer


@onready var play_pause_button: TextureButton = %PlayPauseButton
@onready var bg: ColorRect = %BG
@onready var video_time_label: Label = %VideoTimeLabel
@onready var audio_stream_player: AudioStreamPlayer = %AudioStreamPlayer


var PLAY_BUTTON_ICON: Texture2D = load("res://Assets/Images/Icons/forward.png") as Texture2D
var PAUSE_BUTTON_ICON: Texture2D = load("res://Assets/Images/Icons/pause.png") as Texture2D

var total_video_duration: float = 0
var audios_map: Dictionary = {}


func _process(delta: float) -> void:
	video_time_label.text = seconds_to_minutes_seconds(stream_position)

	play_audio_if_exist(stream_position)

	if stream_position > total_video_duration:
		total_video_duration = stream_position


func seconds_to_minutes_seconds(seconds: float) -> String:
	var minutes = int(seconds / 60)
	var remaining_seconds = int(seconds) % 60

	var minutes_str = str(minutes)
	var seconds_str = str(remaining_seconds)

	if minutes < 10:
		minutes_str = "0" + minutes_str

	if remaining_seconds < 10:
		seconds_str = "0" + seconds_str

	return minutes_str + ":" + seconds_str

func play_audio_if_exist(video_position):
	var audio = audios_map.get(int(video_position))

	if audio:
		audio_stream_player.stop()
		audio_stream_player.stream = audio
		audio_stream_player.play()


func start_video() -> void:
	if not is_playing():
		play()
		bg.hide()
		play_pause_button.texture_normal = PAUSE_BUTTON_ICON

	elif not is_paused():
		set_paused(true)
		play_pause_button.texture_normal = PLAY_BUTTON_ICON
	else:
		set_paused(false)
		play_pause_button.texture_normal = PAUSE_BUTTON_ICON

func add_audio(key, audio):
	audios_map[key] = audio



func _on_play_pause_button_pressed() -> void:
	start_video()

func _on_play_pause_button_mouse_entered() -> void:
	play_pause_button.modulate = Color.DIM_GRAY


func _on_play_pause_button_mouse_exited() -> void:
	var button_color: Color
	if is_playing() and not is_paused():
		button_color = Color("ffffff32")
	else:
		button_color = Color.WHITE

	play_pause_button.modulate = button_color




func _on_finished() -> void:
	play_pause_button.texture_normal = PLAY_BUTTON_ICON
	play_pause_button.modulate = Color.WHITE
	bg.show()
	audio_stream_player.stop()
	audio_stream_player.stream = null
	print("The video has " + str(total_video_duration) + " seconds")

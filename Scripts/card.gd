extends TextureRect
class_name AudioCard

@onready var name_label: Label = %NameLabel
@onready var play_pause_button: TextureButton = %PlayPauseButton
@onready var volume_slider: HSlider = %VolumeSlider
@onready var audio_player: AudioStreamPlayer2D = %AudioPlayer

@export var audio_name: String
@export var audio: AudioStream


var PLAY_BUTTON_ICON: Texture2D = load("res://Assets/Images/Icons/forward.png") as Texture2D
var STOP_BUTTON_ICON: Texture2D = load("res://Assets/Images/Icons/stop.png") as Texture2D


func _ready() -> void:
	name_label.text = audio_name
	audio_player.stream = audio
	volume_slider.max_value = 0
	volume_slider.min_value = -80
	volume_slider.value = volume_slider.max_value


func _process(delta: float) -> void:
	audio_player.volume_db = volume_slider.value


func  _get_drag_data(at_position: Vector2):
	var preview_texture = TextureRect.new() as TextureRect
	preview_texture.texture = texture
	preview_texture.expand_mode = 1
	preview_texture.size = Vector2(54, 96)

	var preview = Control.new()
	preview.add_child(preview_texture)

	set_drag_preview(preview)

	return {
		"card_reference": self,
		"audio": audio,
		"audio_name": audio_name,
		"texture": texture
	}

func _can_drop_data(_pos, data):
	pass

func _drop_data(_pos, data):
	pass

func _on_play_pause_button_mouse_entered() -> void:
	play_pause_button.modulate = Color.DIM_GRAY


func _on_play_pause_button_mouse_exited() -> void:
	var button_color: Color
	if audio_player.is_playing():
		button_color = Color("ffffff32")
	else:
		button_color = Color.WHITE

	play_pause_button.modulate = button_color


func _on_play_pause_button_pressed() -> void:
	if not audio_player.is_playing():
		audio_player.play()
		play_pause_button.texture_normal = STOP_BUTTON_ICON
	else:
		audio_player.stop()
		play_pause_button.texture_normal = PLAY_BUTTON_ICON


func _on_audio_player_finished() -> void:
	play_pause_button.texture_normal = PLAY_BUTTON_ICON
	play_pause_button.modulate = Color.WHITE

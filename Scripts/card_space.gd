extends TextureRect
class_name CardSpace

@onready var value_label: Label = %ValueLabel

@export var value: int = 0

signal has_audio(key, audio)

var with_card_texture: Texture2D
var has_a_audio: bool = false
var audio_name: String
var audio: AudioStream
var original_texture



func _ready() -> void:
	value_label.text = str(value)
	original_texture = texture

func  _get_drag_data(at_position: Vector2):
	var preview_texture = TextureRect.new() as TextureRect
	preview_texture.texture = texture
	preview_texture.expand_mode = 1
	preview_texture.size = Vector2(54, 96)

	var preview = Control.new()
	preview.add_child(preview_texture)

	set_drag_preview(preview)

	var data = {
		"audio": audio,
		"audio_name": audio_name,
		"texture": texture
	}

	audio = null
	audio_name = ""
	has_a_audio = false
	texture = original_texture

	return data

func _can_drop_data(_pos, data):
	return data is Dictionary

func _drop_data(_pos, data):
	texture = data.get("texture")
	audio_name = data.get("audio_name")
	audio = data.get("audio")
	has_a_audio = true

	has_audio.emit(value, audio)

	var original_card = data.get("card_reference") as AudioCard
	if original_card:
		original_card.queue_free()


func _on_mouse_entered() -> void:
	value_label.show()
	custom_minimum_size = Vector2(80, 80)


func _on_mouse_exited() -> void:
	value_label.hide()
	custom_minimum_size = Vector2(0, 0)

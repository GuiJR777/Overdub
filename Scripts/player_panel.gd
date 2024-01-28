extends ColorRect
class_name PlayerPanel

@export var player_nick_name: String
@export var player_color: Color
@export var player_image: Texture2D

@onready var player_nick_name_label: Label = %PlayerNickNameLabel
@onready var player_image_space: TextureRect = %PlayerImage


func _ready() -> void:
	player_nick_name_label.text = player_nick_name
	color = player_color

	if player_image:
		player_image_space.texture = player_image

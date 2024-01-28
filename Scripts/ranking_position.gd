extends HBoxContainer
class_name RankPosition


@export var player_nickname: String
@export var rank_position: int
@export var score: int

@onready var position_label: Label = %PositionLabel
@onready var player_name: Label = %PlayerName
@onready var score_label: Label = %ScoreLabel


func _ready() -> void:
	position_label.text = str(rank_position) + "º"
	player_name.text = player_nickname
	score_label.text = str(score)

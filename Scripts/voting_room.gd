extends Control
class_name VotingRoom

@export var videos_to_vote = []

@onready var videos_to_voting: GridContainer = %VideosToVoting
@onready var positions: VBoxContainer = %Positions

var voting_video_scene: PackedScene = preload("res://Scenes/voting_video_container.tscn")
var raking_position_scene: PackedScene = preload("res://Scenes/ranking_position.tscn")


func add_video(player: Player):
	var voting_container = voting_video_scene.instantiate() as VotingContainer
	videos_to_vote.append(voting_container)

	for child in videos_to_voting.get_children():
		child.queue_free()

	for video in videos_to_vote:
		videos_to_voting.add_child(video)

	voting_container.video_data = player.video_data
	voting_container.player_nickname = player.nick_name
	voting_container.setup()
#
#	var position_container = raking_position_scene.instantiate() as RankPosition
#	position_container.player_nickname = player.nick_name
#	position_container.score= player.score
#	position_container.position = 1


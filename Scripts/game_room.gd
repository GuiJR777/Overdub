extends Node2D


@onready var players_node: Node2D = %PlayersNode
@onready var count_down_label: Label = %CountDownLabel
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var voting_room: VotingRoom = %VotingRoom

var player_scene: PackedScene = preload("res://Scenes/player.tscn")
var video_for_this_match: String



func _ready() -> void:
	var players = Networking.get_players_list()

	for index in range(players.size()):
		var id = players[index][0]
		var nickname = players[index][1]

		var player_instance = player_scene.instantiate() as Player

		if id == Networking.id:
			Networking.player_reference = player_instance

		player_instance.nick_name = nickname
		player_instance.name = str(id)
		player_instance.set_multiplayer_authority(id)
		player_instance.edition_finished.connect(_on_edition_finish)

		players_node.add_child(player_instance)

	animation_player.play("countdown")
	await animation_player.animation_finished

	start_game()


func start_game() -> void:
	define_video()
	start_players_editors()


func define_video():
	if multiplayer.is_server():
		var random_video_path =  ResourcesManager.get_random_video_from_map()
		rpc("set_a_random_video", random_video_path)

@rpc("any_peer", "call_local")
func set_a_random_video(video_path: String) -> void:
	video_for_this_match = video_path


func start_players_editors():
	for player in players_node.get_children():
		player = player as Player

		if player.name.to_int() == Networking.id:
			var video_resource = load(video_for_this_match)

			player.start_editor(video_resource)

func _on_edition_finish(player):
#	voting_room.add_video(player)
	pass



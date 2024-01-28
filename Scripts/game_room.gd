extends Node2D


@onready var players_node: Node2D = %PlayersNode

var player_scene: PackedScene = preload("res://Scenes/player.tscn")


func _ready() -> void:
	var players = Networking.get_players_list()

	for index in range(players.size()):
		var id = players[index][0]
		var nickname = players[index][1]

		var player_instance = player_scene.instantiate() as Player
		player_instance.nick_name = nickname
		player_instance.name = str(id)
		player_instance.set_multiplayer_authority(id)

		players_node.add_child(player_instance)



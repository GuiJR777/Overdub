extends Node


const DEFAULT_IP = "127.0.0.1"
const DEFAULT_PORT = 6007
const MAX_PLAYERS = 4

var ip = DEFAULT_IP
var id = 0
var player_nickname = ""
var peer = null
var players = []
var player_reference: Player

signal player_list_updated
signal server_created_with_success
signal client_created_with_success
signal connection_with_server_fail


func _ready() -> void:
	multiplayer.connected_to_server.connect(self.connected_to_server)
	multiplayer.connection_failed.connect(self.connection_failed)
	multiplayer.server_disconnected.connect(self.server_disconnected)


func update_player_nick_name(new_nickname: String) -> void:
	player_nickname = new_nickname

func update_ip(new_ip: String) -> void:
	ip = new_ip

func get_players_list():
	return players

func get_server_ip():
	var ips = IP.get_local_addresses()

	for _ip in ips:
		if _ip.begins_with("192"):
			return _ip

	return ip

func connected_to_server():
	id = multiplayer.multiplayer_peer.get_unique_id()
	rpc("add_player", id, player_nickname)

func connection_failed():
	peer = null
	multiplayer.set_multiplayer_peer(null)
	connection_with_server_fail.emit()

func server_disconnected():
	get_tree().quit()

func peer_disconnected(id):
	rpc("delete_player", id)


@rpc("any_peer")
func add_player(id, player_nickname):
	if multiplayer.is_server():
		for index in range(players.size()):
			rpc_id(id, "add_player", players[index][0], players[index][1])
		rpc("add_player", id, player_nickname)
	players.append([id, player_nickname, player_reference])
	player_list_updated.emit()
	print("Player " + player_nickname + " is Connected")

@rpc("any_peer", "call_local")
func delete_player(id):
	for index in range(players.size()):
		if players[index][0] == id:
			print("Player " + players[index][1] + " is Desconnected")
			players.remove_at(index)
			player_list_updated.emit()


func create_server():
	peer =ENetMultiplayerPeer.new()
	peer.create_server(DEFAULT_PORT, MAX_PLAYERS)
	multiplayer.set_multiplayer_peer(peer)
	peer.peer_disconnected.connect(self.peer_disconnected)
	id = multiplayer.multiplayer_peer.get_unique_id()
	add_player(id, player_nickname)
	server_created_with_success.emit()


func create_client():
	peer =ENetMultiplayerPeer.new()
	peer.create_client(ip, DEFAULT_PORT)
	multiplayer.set_multiplayer_peer(peer)
	client_created_with_success.emit()

extends Node2D
class_name JoinHostRoom


@onready var ip_input: TextEdit = %IpInput
@onready var player_nick_name_input: TextEdit = %PlayerNickNameInput
@onready var players_list: ItemList = %PlayersList
@onready var warning_label: WarningLabel = %WarningLabel
@onready var host_button: TextureButton = %HostButton
@onready var client_button: TextureButton = %ClientButton
@onready var question_ip: VBoxContainer = %QuestionIp
@onready var show_ip: VBoxContainer = %ShowIp
@onready var ip_to_connect: Label = %IpToConnect
@onready var start_button: TextureButton = %StartButton


func _ready() -> void:
	Networking.player_list_updated.connect(update_players_list)
	Networking.server_created_with_success.connect(server_created)
	Networking.client_created_with_success.connect(client_created)
	Networking.connection_with_server_fail.connect(failed_to_connect_server)


@rpc("any_peer", "call_local")
func start_game() -> void:
	ScenesManager.change_scene(ScenesManager.GAME_ROOM)


func update_players_list() -> void:
	var players_connected = Networking.get_players_list()
	players_list.clear()

	for index in range(players_connected.size()):
		if players_connected[index][0] == Networking.id:
			players_list.add_item(players_connected[index][1])
			var last_index = players_list.item_count
			players_list.set_item_custom_bg_color(last_index -1, Color("FC8686"))
		else:
			players_list.add_item(players_connected[index][1])


func is_valid_nickname() -> bool:
	if player_nick_name_input.text == "":
		warning_label.show_error("Você precisa definir um nickname valido")
		return false

	Networking.update_player_nick_name(player_nick_name_input.text)
	return true

func is_valid_ip() -> bool:
	if ip_input.text == "":
		warning_label.show_error("Você precisa definir um IP valido")
		return false

	Networking.update_ip(ip_input.text)
	return true

func disable_buttons():
	host_button.disabled = true
	client_button.disabled = true

func server_created():
	warning_label.show_success("Servidor criado com sucesso!")
	disable_buttons()
	question_ip.hide()
	ip_to_connect.text = Networking.get_server_ip()
	show_ip.show()

func client_created():
	warning_label.show_success("Logado no servidor com sucesso!")
	disable_buttons()
	start_button.hide()

func failed_to_connect_server():
	warning_label.show_error("Não foi possivel logar no servidor")


func _on_back_button_pressed() -> void:
	ScenesManager.change_scene(ScenesManager.MAIN_MENU)


func _on_host_button_pressed() -> void:
	if is_valid_nickname():
		Networking.create_server()


func _on_client_button_pressed() -> void:
	if is_valid_nickname() and is_valid_ip():
		Networking.create_client()


func _on_start_button_pressed() -> void:
	if multiplayer.is_server():
		rpc("start_game")


extends Node2D

@export var nick_name: String

var edition_room_scene: PackedScene = preload("res://Scenes/edition_room.tscn")
var panel_scene: PackedScene = preload("res://Scenes/player_panel.tscn")


func _enter_tree() -> void:
	set_multiplayer_authority(name.to_int())


func get_panel() -> PlayerPanel:
	var player_panel = panel_scene.instantiate() as PlayerPanel
	player_panel.player_nick_name = nick_name

	return player_panel

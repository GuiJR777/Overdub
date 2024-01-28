extends Node


@onready var transition_scene: PackedScene = preload("res://Scenes/transition_scene.tscn")

const SPLASH_SCREEN = "res://Scenes/splash_screen.tscn"
const MAIN_MENU = "res://Scenes/main_menu.tscn"
const JOIN_HOST_ROOM = "res://Scenes/join_host_room.tscn"
const GAME_ROOM = "res://Scenes/game_room.tscn"

var scene_to_transition: String

func change_scene(scene_name: String) -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	scene_to_transition = scene_name
	get_tree().change_scene_to_packed(transition_scene)

extends Node2D
class_name Player

@export var nick_name: String

@onready var video_stream_player: VideoStreamPlayer = %VideoStreamPlayer

var edition_room_scene: PackedScene = preload("res://Scenes/edition_room.tscn")
var edition_room_instance: EditionRoom

var last_video_edited: VideoPlayer
var video_data ={}
var score: int

signal edition_finished(player)

func _ready() -> void:
	create_edition_room()

func create_edition_room() -> void:
	edition_room_instance = edition_room_scene.instantiate() as EditionRoom
	edition_room_instance.player_reference = self
	edition_room_instance.finish_edition.connect(_on_edit_finished)



func start_editor(video):
	add_child(edition_room_instance)
	edition_room_instance.start_video(video)


func _on_edit_finished() -> void:
	for child in get_children():
		if child is EditionRoom:
			child.queue_free()
	edition_finished.emit(self)


extends Node

const MUSICS_FOLDER_PATH = "res://Assets/Sounds/Memes/"
const VIDEOS_FOLDER_PATH = "res://Assets/Videos/Memes/"

var music_map: Dictionary
var videos_map: Dictionary


func _ready() -> void:
	music_map = mapping_files_in_path(MUSICS_FOLDER_PATH, "import")

	videos_map = mapping_files_in_path(VIDEOS_FOLDER_PATH, "ogv")


func mapping_files_in_path(path: String, extension: String) -> Dictionary:
	var dir = DirAccess.open(path)
	var dict_files = {}

	dir.list_dir_begin()
	var file_path = dir.get_next()

	while file_path != "":
		if file_path.get_extension().to_lower() == extension:
			var file_name = file_path.replace(".import", "")
			dict_files[file_name] = path.path_join(file_name)
		file_path = dir.get_next()

	dir.list_dir_end()

	return dict_files

func get_random_video_from_map() -> String:
	if videos_map.size() == 0:
		print("No videos found in the map.")
		return ""

	var video_names = videos_map.keys()
	var random_index = randi() % video_names.size()
	var random_video_name = video_names[random_index]
	return videos_map[random_video_name]

func get_random_music_from_map() -> String:
	if music_map.size() == 0:
		print("No videos found in the map.")
		return ""

	var music_name = music_map.keys()
	var random_index = randi() % music_name.size()
	var random_music_name = music_name[random_index]
	return music_map[random_music_name]



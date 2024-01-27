class_name TransitionScene
extends Control

@onready var progress_bar: TextureProgressBar = %TextureProgressBar
@onready var progress_label: Label = %Label

var transition_to: String
var progress: Array = []
var scene_load_status: int = 0


func _ready() -> void:
	transition_to = ScenesManager.scene_to_transition
	ResourceLoader.load_threaded_request(transition_to)


func _process(delta: float) -> void:
	scene_load_status = ResourceLoader.load_threaded_get_status(transition_to, progress)

	var progress_value = floor(progress[0] * 100)
	progress_bar.value = int(progress_value)
	progress_label.text = str(progress_value) + " %"

	if scene_load_status == ResourceLoader.THREAD_LOAD_LOADED:
		var new_scene = ResourceLoader.load_threaded_get(transition_to)
		get_tree().change_scene_to_packed(new_scene)

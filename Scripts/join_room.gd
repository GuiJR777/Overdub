extends Node2D
class_name CreatePlayerRoom

@onready var player_name: TextEdit = %PlayerName
@onready var color_picker_button: ColorPickerButton = %ColorPickerButton
@onready var create_button: TextureButton = $CanvasLayer/MarginContainer/HBoxContainer/VBoxContainer/VBoxContainer/CreateButton



func _process(delta: float) -> void:
	if player_name.text != "" and color_picker_button.color != Color.BLACK:
		create_button.show()

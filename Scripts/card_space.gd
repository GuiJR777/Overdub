extends ColorRect
class_name CardSpace

@onready var value_label: Label = %ValueLabel

@export var value: int = 0


func _ready() -> void:
	value_label.text = str(value)


func _on_mouse_entered() -> void:
	value_label.show()
	custom_minimum_size = Vector2(80, 80)


func _on_mouse_exited() -> void:
	value_label.hide()
	custom_minimum_size = Vector2(0, 0)

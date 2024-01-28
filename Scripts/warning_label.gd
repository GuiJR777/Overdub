extends Label
class_name WarningLabel


func show_error(text_to_show: String):
	text = text_to_show
	modulate = Color.RED
	show()
	await get_tree().create_timer(5).timeout
	hide()

func show_success(text_to_show: String):
	text = text_to_show
	modulate = Color.DARK_GREEN
	show()
	await get_tree().create_timer(5).timeout
	hide()

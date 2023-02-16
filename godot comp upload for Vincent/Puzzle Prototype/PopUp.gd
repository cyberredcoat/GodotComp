extends Node2D

var _last_mouse_position

onready var _pm = $PopupMenu

func _input(event):
	if event is InputEventMouseButton and event.button_index == BUTTON_RIGHT:
		_last_mouse_position = get_global_mouse_position()
		_pm.popup(Rect2(_last_mouse_position.x, _last_mouse_position.y, _pm.rect_size.x, _pm.rect_size.y))

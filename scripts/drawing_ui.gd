class_name DrawingUI
extends CanvasLayer


signal color_changed(color: Color)


func _on_color_switcher_color_changed(color: Color) -> void:
	color_changed.emit(color)

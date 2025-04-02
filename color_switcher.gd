class_name ColorSwitcher
extends CanvasLayer


@export var palette: Palette

var current_color = Color(1, 1, 1, 1)
var current_color_index = 0


func set_palette(new_palette: PackedColorArray):
	palette.set_palette(new_palette)
	palette.color_changed.connect(_on_new_color)
	current_color = new_palette[0]
	current_color_index = 0
	

func _on_new_color(index: int, color: Color):
	current_color_index = index
	current_color = color

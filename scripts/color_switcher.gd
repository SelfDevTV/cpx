class_name ColorSwitcher
extends Control


@export var palette: Palette

var current_color = Color(1, 1, 1, 1)
var current_color_index = 0

signal color_changed(color: Color)

func _process(_delta: float) -> void:
	if Input.is_anything_pressed():
		for i in range(1, 10):
			if Input.is_action_just_pressed(str(i)):
				if i - 1 < Globals.pixel_canvas.palette.size():
					current_color = Globals.pixel_canvas.palette[i - 1]
					current_color_index = i - 1
					color_changed.emit(current_color)
					palette.set_primary_color(current_color)


func set_palette(new_palette: PackedColorArray):
	palette.set_palette(new_palette)
	
	current_color = new_palette[0]
	current_color_index = 0
	

func _on_palette_color_changed(_index: int, color: Color) -> void:
	color_changed.emit(color)

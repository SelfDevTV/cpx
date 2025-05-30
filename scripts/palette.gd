class_name Palette
extends Control

@export var btn: PackedScene
@onready var palette_container = %PaletteContainer

signal color_changed(index: int, color: Color)

var buttons: Array[PaletteButton] = []

func _ready() -> void:
	if not Globals.pixel_canvas:
		return
	set_palette(Globals.pixel_canvas.palette)

func set_primary_color(color: Color) -> void:
	for button in buttons:
		if button.color == color:
			button.set_is_primary(true)
		else:
			button.set_is_primary(false)


func set_palette(palette: PackedColorArray) -> void:
	for child in palette_container.get_children():
		child.queue_free()
	buttons.clear()
	for i in range(palette.size()):
		var button = btn.instantiate() as PaletteButton
	   
		button.set_button_color(i, palette[i])
		button.set_button_text(str(i + 1))
		
		button.pressed.connect(_on_color_changed.bind(i, palette[i]))
		palette_container.add_child(button)
		buttons.append(button)
	buttons[0].set_is_primary(true)
	color_changed.emit(0, palette[0])

func _on_color_changed(index: int, color: Color) -> void:
	for i in range(buttons.size()):
		if i == index:
			buttons[i].set_is_primary(true)
		else:
			buttons[i].set_is_primary(false)

	color_changed.emit(index, color)

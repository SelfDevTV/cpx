class_name DrawingUI
extends CanvasLayer


@export var pixels_drawn_lbl: Label
@export var pixels_left_lbl: Label
@export var progress_bar: ProgressBar
signal color_changed(color: Color)


func _ready() -> void:
	Globals.pixel_canvas.pixel_drawn.connect(_on_pixel_drawn)
	progress_bar.max_value = Globals.pixel_canvas.pixel_colors.size()
	progress_bar.value = Globals.pixel_canvas.amount_correct_colors
	pixels_drawn_lbl.text = "Correct: " + str(Globals.pixel_canvas.amount_correct_colors)
	pixels_left_lbl.text = "Remaining: " + str(Globals.pixel_canvas.get_pixels_remaining())
	

func _on_pixel_drawn() -> void:
	if not Globals.pixel_canvas.amount_correct_colors:
		return
	pixels_drawn_lbl.text = "Correct: " + str(Globals.pixel_canvas.amount_correct_colors)
	pixels_left_lbl.text = "Remaining: " + str(Globals.pixel_canvas.get_pixels_remaining())
	progress_bar.value = Globals.pixel_canvas.amount_correct_colors

func _on_color_switcher_color_changed(color: Color) -> void:
	color_changed.emit(color)
	if not Globals.pixel_canvas.amount_correct_colors:
		return
	pixels_drawn_lbl.text = str(Globals.pixel_canvas.amount_correct_colors)

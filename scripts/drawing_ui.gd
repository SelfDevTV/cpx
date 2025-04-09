class_name DrawingUI
extends CanvasLayer


@export var pixels_drawn_lbl: Label
@export var pixels_left_lbl: Label
@export var progress_bar: ProgressBar
signal color_changed(color: Color)


func _ready() -> void:
	Globals.pixel_canvas.pixel_drawn.connect(_on_pixel_drawn)
	Globals.pixel_canvas.upgrades.painter_added.connect(_on_painter_added)
	progress_bar.max_value = Globals.pixel_canvas.pixel_colors.size()
	progress_bar.value = Globals.pixel_canvas.amount_correct_colors
	pixels_drawn_lbl.text = "Credits: " + str(Globals.pixel_canvas.upgrades.credits)
	pixels_left_lbl.text = "Remaining: " + str(Globals.pixel_canvas.get_pixels_remaining())
	
func _on_painter_added(_painter_r: PainterResource) -> void:
	pixels_drawn_lbl.text = "Credits: " + str(Globals.pixel_canvas.upgrades.credits)

func _on_pixel_drawn() -> void:
	if not Globals.pixel_canvas.amount_correct_colors:
		return
	pixels_drawn_lbl.text = "Credits: " + str(Globals.pixel_canvas.upgrades.credits)
	pixels_left_lbl.text = "Remaining: " + str(Globals.pixel_canvas.get_pixels_remaining())
	progress_bar.value = Globals.pixel_canvas.amount_correct_colors

func _on_color_switcher_color_changed(color: Color) -> void:
	color_changed.emit(color)

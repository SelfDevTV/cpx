class_name Painter
extends Node2D

@onready var pixel_canvas: PixelCanvas = Globals.pixel_canvas

enum State {
	MOVING,
	PAINTING,
	IDLING
}

var state: State = State.IDLING
var target_pos: Vector2
var target_pixel: Vector2i

var painted_pixels: Array[Vector2i] = []

@export var move_speed: float = 100.0

var painter_resource: PainterResource
var canvas: Canvas


func _ready() -> void:
	# get random position from the drawing canvas
	canvas = get_tree().get_first_node_in_group("canvas")
	state = State.MOVING
	target_pixel = get_rand_pixel()
	target_pos = get_rand_pos(target_pixel)
	print("target_pos: ", target_pos)

func _process(delta: float) -> void:
	match state:
		State.MOVING:
			var new_pos = global_position.move_toward(target_pos, move_speed * delta)
			global_position = new_pos
			if global_position.distance_to(target_pos) == 0:
				$PaintTimer.start()
				state = State.PAINTING
				
		State.PAINTING:
			pass
		State.IDLING:
			pass

func get_rand_pixel() -> Vector2i:
	var px = Vector2i(randi_range(0, pixel_canvas.canvas_tiled_size.x - 1), randi_range(0, pixel_canvas.canvas_tiled_size.y - 1))
	while painter_resource.painted_pixels.has(px):
		px = Vector2i(randi_range(0, pixel_canvas.canvas_tiled_size.x - 1), randi_range(0, pixel_canvas.canvas_tiled_size.y - 1))
	return px

func get_rand_pos(pixel: Vector2i) -> Vector2:
	return canvas.global_position + Vector2(pixel.x * pixel_canvas.pixel_size, pixel.y * pixel_canvas.pixel_size)

func _on_paint_timer_timeout() -> void:
	var correct_col = pixel_canvas.get_correct_pixel_color(target_pixel.x, target_pixel.y)
	canvas.draw_on_pixel(target_pixel.x, target_pixel.y, correct_col)
	painter_resource.painted_pixels.append(target_pixel)
	target_pixel = get_rand_pixel()
	target_pos = get_rand_pos(target_pixel)
	state = State.MOVING

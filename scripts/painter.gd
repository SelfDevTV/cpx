class_name Painter
extends Node2D

@onready var pixel_canvas: PixelCanvas = Globals.pixel_canvas

enum State {
	MOVING,
	PAINTING,
	IDLING
}

enum PainterUpgrades {
    SPEED,
    PAINT_COOLDOWN,
    CREDITS_PER_PIXEL
}

var state: State = State.IDLING
var target_pos: Vector2
var target_pixel: Vector2i


@export var move_speed_base: float = 50.0

var painter_resource: PainterResource
var canvas: Canvas


func _ready() -> void:
	# get random position from the drawing canvas
	canvas = get_tree().get_first_node_in_group("canvas")
	state = State.MOVING
	target_pixel = get_rand_pixel()
	target_pos = get_rand_pos(target_pixel)
	

func setup(painter_r: PainterResource) -> void:
	painter_resource = painter_r
	painter_resource.painter_upgraded.connect(_on_painter_upgraded)
	init_upgrades()

func _process(delta: float) -> void:
	match state:
		State.MOVING:
			var new_pos = global_position.move_toward(target_pos, move_speed_base * painter_resource.speed * delta)
			global_position = new_pos
			if global_position.distance_to(target_pos) == 0:
				$PaintTimer.start()
				state = State.PAINTING
				
		State.PAINTING:
			pass
		State.IDLING:
			pass

func _on_painter_upgraded(_painter: PainterResource, upgrade: PainterUpgrades) -> void:
	apply_upgrade(upgrade)


func init_upgrades() -> void:
	$PaintTimer.wait_time = painter_resource.paint_cooldown
	

func apply_upgrade(upgrade: PainterUpgrades) -> void:
	match upgrade:
		PainterUpgrades.PAINT_COOLDOWN:
			$PaintTimer.wait_time = painter_resource.paint_cooldown
		

# if no more pixels left it returns a pixel with -1, -1
func get_rand_pixel() -> Vector2i:
	if pixel_canvas.painted_pixels.size() == pixel_canvas.pixel_colors.size():
		return Vector2i(-1, -1)

		
	var px = Vector2i(randi_range(0, pixel_canvas.canvas_tiled_size.x - 1), randi_range(0, pixel_canvas.canvas_tiled_size.y - 1))
	while pixel_canvas.painted_pixels.has(px):
		px = Vector2i(randi_range(0, pixel_canvas.canvas_tiled_size.x - 1), randi_range(0, pixel_canvas.canvas_tiled_size.y - 1))
	return px

func get_rand_pos(pixel: Vector2i) -> Vector2:
	return canvas.global_position + Vector2(pixel.x * pixel_canvas.pixel_size, pixel.y * pixel_canvas.pixel_size)

func calc_new_painter_objective() -> void:
	target_pixel = get_rand_pixel()
	if target_pixel == Vector2i(-1, -1):
		# no more pixels left
		$PaintTimer.stop()
		state = State.IDLING
		return
	target_pos = get_rand_pos(target_pixel)
	state = State.MOVING

func _on_paint_timer_timeout() -> void:
	# draw the pixel
	var correct_col = pixel_canvas.get_correct_pixel_color(target_pixel.x, target_pixel.y)
	canvas.draw_on_pixel(target_pixel.x, target_pixel.y, correct_col, painter_resource.credits_per_pixel_drawn)

	# get new target pixel
	calc_new_painter_objective()

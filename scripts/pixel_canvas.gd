class_name PixelCanvas
extends Resource

@export var default_color: Color = Color(1, 1, 1, 1)

@export var pixel_size: int
@export var canvas_size: Vector2i

@export var canvas_tiled_size: Vector2i


@export var correct_colors: PackedColorArray
@export var pixel_colors: PackedColorArray

@export var palette: PackedColorArray
@export var image: Image
@export var amount_correct_colors: int = 0

@export var name: String

signal pixel_drawn()

func create(new_pixel_size: int, new_canvas_size: Vector2i, new_palette: PackedColorArray, new_image: Image) -> PixelCanvas:
	pixel_size = new_pixel_size
	canvas_size = new_canvas_size
	image = new_image
	palette = new_palette

	pixel_colors = PackedColorArray()
	palette = new_palette

	canvas_tiled_size = Vector2i(canvas_size.x / pixel_size, canvas_size.y / pixel_size)

	for i in range(canvas_tiled_size.x * canvas_tiled_size.y):
		pixel_colors.append(default_color)
		var correct_color = new_image.get_pixel(i % canvas_tiled_size.x * pixel_size, i / canvas_tiled_size.x * pixel_size)
		correct_colors.append(correct_color)
	return self


func set_pixel_color(x: int, y: int, color: Color) -> void:
	if x < 0 or x >= canvas_tiled_size.x or y < 0 or y >= canvas_tiled_size.y:
		return
	if color == get_pixel_color(x, y):
		return
	if color == get_correct_pixel_color(x, y):
		amount_correct_colors += 1
	else:
		amount_correct_colors -= 1

	pixel_colors[y * canvas_tiled_size.x + x] = color
	emit_signal("pixel_drawn")

func get_pixel_color(x: int, y: int) -> Color:
	if x < 0 or x >= canvas_tiled_size.x or y < 0 or y >= canvas_tiled_size.y:
		return default_color

	return pixel_colors[y * canvas_tiled_size.x + x]

func get_correct_pixel_color(x: int, y: int) -> Color:
	if x < 0 or x >= canvas_tiled_size.x or y < 0 or y >= canvas_tiled_size.y:
		return default_color

	return correct_colors[y * canvas_tiled_size.x + x]

func get_pixel_number(x: int, y: int) -> int:
	if x < 0 or x >= canvas_tiled_size.x or y < 0 or y >= canvas_tiled_size.y:
		return -1
	var image_pixel_color = image.get_pixel(x * pixel_size, y * pixel_size)
	
	for i in range(palette.size()):
		var c = palette[i]
		if c.is_equal_approx(image_pixel_color):
			return i + 1
	return -1

func get_pixels_remaining() -> int:
	return pixel_colors.size() - amount_correct_colors


func to_image() -> Image:
	var img = Image.create(canvas_size.x, canvas_size.y, false, Image.FORMAT_RGBA8)
	
	for y in range(canvas_size.y / pixel_size):
		for x in range(canvas_size.x / pixel_size):
			for i in range(pixel_size):
				for j in range(pixel_size):
					var pixel_x = x * pixel_size + j
					var pixel_y = y * pixel_size + i
					if pixel_x < canvas_size.x and pixel_y < canvas_size.y:
						img.set_pixel(pixel_x, pixel_y, pixel_colors[y * (canvas_size.x / pixel_size) + x])
			
		   
	return img

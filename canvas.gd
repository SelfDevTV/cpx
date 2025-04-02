class_name Canvas
extends TextureRect


@export var godot_icon: Texture2D

var PIXEL_SIZE = Globals.pixel_canvas.pixel_size

var pixel_canvas: PixelCanvas = Globals.pixel_canvas

var img: Image
var tex: ImageTexture

var is_mouse_down: bool = false
var last_drag_pos: Vector2i


@export var num_texture_scene: PackedScene
@export var color_switcher: ColorSwitcher

var num_image: Image


func _gui_input(event: InputEvent) -> void:
	var mouse_pos = get_global_mouse_position()
	var pixel_x = int(mouse_pos.x / PIXEL_SIZE)
	var pixel_y = int(mouse_pos.y / PIXEL_SIZE)
	if pixel_x < 0 or pixel_x >= pixel_canvas.canvas_tiled_size.x or pixel_y < 0 or pixel_y >= pixel_canvas.canvas_tiled_size.y:
			return
	if event.is_action_released("click"):
		is_mouse_down = false

	if event.is_action_pressed("click"):
		is_mouse_down = true
		last_drag_pos = Vector2i(pixel_x, pixel_y)
		draw_on_pixel(pixel_x, pixel_y)

		
func _process(_delta: float) -> void:
	if is_mouse_down:
		var mouse_pos = get_global_mouse_position()
		var pixel_x = int(mouse_pos.x / PIXEL_SIZE)
		var pixel_y = int(mouse_pos.y / PIXEL_SIZE)
		mouse_drag(mouse_pos, pixel_x, pixel_y)
		last_drag_pos = Vector2i(pixel_x, pixel_y)


func _on_mouse_exited() -> void:
	is_mouse_down = false


func mouse_drag(_mouse_pos: Vector2, pixel_x: int, pixel_y: int) -> void:
	if last_drag_pos != null:
		var points = Utils.bresenham_line(last_drag_pos.x, last_drag_pos.y, pixel_x, pixel_y)
		for p in points:
			draw_on_pixel(p.x, p.y)
			

func draw_on_pixel(pixel_x, pixel_y):
	# update image
	for x in range(PIXEL_SIZE):
		for y in range(PIXEL_SIZE):
				img.set_pixel(pixel_x * PIXEL_SIZE + x, pixel_y * PIXEL_SIZE + y, color_switcher.current_color)

	# if not correct color, blend number
	if pixel_canvas.get_correct_pixel_color(pixel_x, pixel_y) != color_switcher.current_color:
		var pixel_num = pixel_canvas.get_pixel_number(pixel_x, pixel_y)
		img.blend_rect(NumberTexturesContainer.number_textures.get(pixel_num), Rect2i(0, 0, PIXEL_SIZE, PIXEL_SIZE), Vector2i(pixel_x * PIXEL_SIZE, pixel_y * PIXEL_SIZE))

	# update resourec
	pixel_canvas.set_pixel_color(pixel_x, pixel_y, color_switcher.current_color)
	
	# update texture
	tex.update(img)

func _ready() -> void:
	color_switcher.set_palette(pixel_canvas.palette)
	
	img = pixel_canvas.to_image()
	tex = ImageTexture.create_from_image(img)
	texture = tex
	# num_image = await _generate_text_tile(1)
	_blend_numbers_on_pixels()


func _blend_numbers_on_pixels():
	for x in range(pixel_canvas.canvas_tiled_size.x):
		for y in range(pixel_canvas.canvas_tiled_size.y):
			var pixel_num = pixel_canvas.get_pixel_number(x, y)
			# num_image = await _generate_text_tile(pixel_num)
			img.blend_rect(NumberTexturesContainer.number_textures.get(pixel_num), Rect2i(0, 0, PIXEL_SIZE, PIXEL_SIZE), Vector2i(x * PIXEL_SIZE, y * PIXEL_SIZE))
			
				
	tex.update(img)

# func _generate_text_tile(num: int) -> Image:
# 	var viewport = SubViewport.new()
# 	viewport.size = Vector2(PIXEL_SIZE, PIXEL_SIZE)
# 	viewport.transparent_bg = true
# 	# viewport.render_target_clear_mode = SubViewport.CLEAR_MODE_ALWAYS
	
# 	viewport.render_target_update_mode = SubViewport.UPDATE_ALWAYS
# 	# viewport.render_target_update_mode = SubViewport.UPDATE_ALWAYS
# 	var num_tex = NumberTexturesContainer.number_textures.get(num)
	
# 	var num_lbl = num_texture_scene.instantiate() as TextureRect
# 	viewport.add_child(num_lbl)
# 	num_lbl.position = Vector2.ZERO


# 	add_child(viewport)

# 	await RenderingServer.frame_post_draw

# 	var image = viewport.get_texture().get_image()

extends Node


@export var number_textures_light: Dictionary[int, Image]
@export var number_textures_dark: Dictionary[int, Image]
@export var num_texture_scene: PackedScene

@export var numbers: Dictionary[int, Texture2D]


func setup():
	for i in range(Globals.pixel_canvas.palette.size()):
		var image_light = await _generate_text_tile(i + 1)
		var iamge_dark = await _generate_text_tile(i + 1, true)
		number_textures_light.set(i + 1, image_light)
		number_textures_dark.set(i + 1, iamge_dark)
	print("finished setup")


func _generate_text_tile(num: int, dark: bool = false) -> Image:
	var viewport = SubViewport.new()
	viewport.size = Vector2(Globals.pixel_canvas.pixel_size, Globals.pixel_canvas.pixel_size)
	viewport.transparent_bg = true
			# viewport.render_target_clear_mode = SubViewport.CLEAR_MODE_ALWAYS
			
	viewport.render_target_update_mode = SubViewport.UPDATE_ALWAYS
			# viewport.render_target_update_mode = SubViewport.UPDATE_ALWAYS
	var number_texture = numbers.get(num) as Texture2D

			
	var num_lbl = num_texture_scene.instantiate() as TextureRect
	num_lbl.texture = number_texture
	if dark:
		num_lbl.modulate = Color(0, 0, 0, 1)
	viewport.add_child(num_lbl)
	num_lbl.position = Vector2.ZERO


	add_child(viewport)

	await RenderingServer.frame_post_draw

	var image = viewport.get_texture().get_image()
	viewport.queue_free()


	return image

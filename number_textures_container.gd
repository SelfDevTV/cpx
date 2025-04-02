extends Node


@export var number_textures: Dictionary[int, Image]
@export var num_texture_scene: PackedScene

@export var numbers: Dictionary[int, Texture2D]


func setup():
	for i in range(Globals.pixel_canvas.palette.size()):
		var image = await _generate_text_tile(i + 1)
		number_textures.set(i + 1, image)


func _generate_text_tile(num: int) -> Image:
	var viewport = SubViewport.new()
	viewport.size = Vector2(Globals.pixel_canvas.pixel_size, Globals.pixel_canvas.pixel_size)
	viewport.transparent_bg = true
			# viewport.render_target_clear_mode = SubViewport.CLEAR_MODE_ALWAYS
			
	viewport.render_target_update_mode = SubViewport.UPDATE_ALWAYS
			# viewport.render_target_update_mode = SubViewport.UPDATE_ALWAYS
	var number_texture = numbers.get(num)
			
	var num_lbl = num_texture_scene.instantiate() as TextureRect
	num_lbl.texture = number_texture
	viewport.add_child(num_lbl)
	num_lbl.position = Vector2.ZERO


	add_child(viewport)

	await RenderingServer.frame_post_draw

	var image = viewport.get_texture().get_image()
	viewport.queue_free()


	return image

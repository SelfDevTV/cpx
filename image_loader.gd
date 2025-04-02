extends Node2D

@export var api_path: String = "http://localhost:4000/random"

func _ready() -> void:
	$Button.pressed.connect(func(): get_tree().change_scene_to_file("res://play.tscn"))
	$Button.disabled = true
	$Button.text = "Loading..."
	$HTTPRequest.request_completed.connect(_on_request_completed)
	$HTTPRequest.request(api_path)


func _on_request_completed(_result: int, _response_code: int, _headers: Array, body: PackedByteArray) -> void:
	var json = JSON.parse_string(body.get_string_from_utf8())
	var imgBase64 = json["image"]
	var pixel_size = json["pixelSize"]
	var w = json["width"]
	var h = json["height"]


	var palette: Array = json["palette"]

	var new_palette = PackedColorArray()

	for i in range(palette.size()):
		var color = Color.hex(palette[i]["color"].to_int())
		new_palette.append(color)
	
	$Palette.set_palette(new_palette)
	
	imgBase64 = imgBase64.replace("data:image/png;base64,", "")
	
	var imgData = Marshalls.base64_to_raw(imgBase64)
	var img = Image.new()
	img.load_png_from_buffer(imgData)

	
	var texture = ImageTexture.create_from_image(img)
	var sprite = Sprite2D.new()
	sprite.centered = false
	sprite.texture = texture


	print(sprite.texture.get_width())
	print(sprite.texture.get_height())
	add_child(sprite)
	sprite.position = Vector2(0, 0)

	Globals.pixel_canvas = PixelCanvas.new().create(pixel_size, Vector2i(w, h), new_palette, img)
	NumberTexturesContainer.setup()


	$Button.disabled = false
	$Button.text = "Play"

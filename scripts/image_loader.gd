extends Node2D

@export var api_path: String = "http://localhost:4000/random"
@export var sprite: Sprite2D

func _ready() -> void:
	%Play.pressed.connect(func(): get_tree().change_scene_to_file("res://scenes/play.tscn"))
	%HTTPRequest.request_completed.connect(_on_request_completed)
	fetch_image()

func fetch_image() -> void:
	%Play.disabled = true
	%Play.text = "Loading..."
	%Random.disabled = true
	%Random.text = "Fetching..."
	%HTTPRequest.request(api_path)


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
	

	imgBase64 = imgBase64.replace("data:image/png;base64,", "")
	
	var imgData = Marshalls.base64_to_raw(imgBase64)
	var img = Image.new()
	img.load_png_from_buffer(imgData)

	
	var texture = ImageTexture.create_from_image(img)
	
	sprite.centered = false
	sprite.texture = texture


	var margin = 50
	sprite.position = (get_viewport_rect().size - sprite.texture.get_size()) / 2
	sprite.position.y += margin / 2
	var scale_factor = min(get_viewport_rect().size.x / sprite.texture.get_size().x, (get_viewport_rect().size.y - margin) / sprite.texture.get_size().y)
	sprite.scale = Vector2(scale_factor, scale_factor)
	

	Globals.pixel_canvas = PixelCanvas.new().create(pixel_size, Vector2i(w, h), new_palette, img)
	NumberTexturesContainer.setup()


	%Play.disabled = false
	%Play.text = "Play"
	%Random.disabled = false
	%Random.text = "New Random"


func _on_random_pressed() -> void:
	fetch_image()

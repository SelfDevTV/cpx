extends Node

func save_drawing(drawing: PixelCanvas, drawing_name: String) -> void:
	var s = ResourceSaver.save(drawing, "res://drawings/" + drawing_name + ".tres")
	print(s)

func load_drawing(drawing_name: String) -> PixelCanvas:
	var drawing = ResourceLoader.load("res://drawings/" + drawing_name + ".tres", "PixelCanvas", ResourceLoader.CACHE_MODE_IGNORE)
	if drawing == null:
		print("Error loading drawing: ", drawing_name)
		return null
	return drawing

extends Node

# returns true if the drawing was saved successfully
func save_drawing(drawing: PixelCanvas, drawing_name: String, override: bool = false) -> bool:
	var all_drawings = DirAccess.open("user://drawings")
	all_drawings.list_dir_begin()
	var exists = all_drawings.file_exists(drawing_name + ".tres")
	if exists and not override:
		return false
	ResourceSaver.save(drawing, "user://drawings/" + drawing_name + ".tres")
	return true

func load_drawing(drawing_name: String) -> PixelCanvas:
	var drawing = ResourceLoader.load("user://drawings/" + drawing_name + ".tres", "PixelCanvas", ResourceLoader.CACHE_MODE_IGNORE) as PixelCanvas
	
	if drawing == null:
		print("Error loading drawing: ", drawing_name)
		return null
	drawing.upgrades.init_painter_signals()
	return drawing

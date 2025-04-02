extends Node


var save_path: String = "user://drawings/"


func save_drawing(drawing: PixelCanvas, drawing_name: String) -> void:
	var s = ResourceSaver.save(drawing, "res://drawings/" + drawing_name + ".res")
	print(s)

func load_drawing(drawing_name: String) -> Resource:
	var drawing = ResourceLoader.load("res://drawings/" + drawing_name + ".res")
	if drawing == null:
		print("Error loading drawing: ", drawing_name)
		return null
	return drawing

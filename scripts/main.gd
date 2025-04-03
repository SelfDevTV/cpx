class_name Main
extends Node2D


func _on_load_existing_image_pressed() -> void:
	var dir = DirAccess.open("res://drawings")
	dir.list_dir_begin()
	var first_file = dir.get_next()
	var drawing = SaveAndLoadManager.load_drawing(first_file.replace(".tres", ""))
	Globals.pixel_canvas = drawing
	await NumberTexturesContainer.setup()
	get_tree().change_scene_to_file("res://scenes/play.tscn")


func _on_create_from_internet_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/image_loader.tscn")

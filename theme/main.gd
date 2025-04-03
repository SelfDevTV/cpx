class_name Main
extends Node2D


func _on_load_existing_image_pressed() -> void:
	var drawing = SaveAndLoadManager.load_drawing("first")
	Globals.pixel_canvas = drawing
	await NumberTexturesContainer.setup()
	get_tree().change_scene_to_file("res://play.tscn")


func _on_create_from_internet_pressed() -> void:
	get_tree().change_scene_to_file("res://image_loader.tscn")

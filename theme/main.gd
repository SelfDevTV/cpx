class_name Main
extends Node2D


func _on_load_existing_image_pressed() -> void:
	var drawing = SaveAndLoadManager.load_drawing("first")
	Globals.pixel_canvas = drawing
	get_tree().change_scene_to_file("res://play.tscn")

class_name Play
extends Node2D


func _on_button_pressed() -> void:
	SaveAndLoadManager.save_drawing(Globals.pixel_canvas, "first")
class_name Play
extends Node2D


func _on_button_pressed() -> void:
	SaveAndLoadManager.save_drawing(Globals.pixel_canvas, Globals.pixel_canvas.name, true)

func _on_save_interval_timeout() -> void:
	SaveAndLoadManager.save_drawing(Globals.pixel_canvas, Globals.pixel_canvas.name, true)

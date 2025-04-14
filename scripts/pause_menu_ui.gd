class_name PauseMenuUI
extends CanvasLayer

@export var main_scene: PackedScene


func _save_progress() -> void:
	if not Globals.pixel_canvas:
		return
	SaveAndLoadManager.save_drawing(Globals.pixel_canvas, Globals.pixel_canvas.name, true)


func _on_back_menu_pressed() -> void:
	_save_progress()
	get_tree().change_scene_to_file(main_scene.resource_path)
	Globals.resume()


func _on_exit_game_pressed() -> void:
	_save_progress()
	get_tree().quit()

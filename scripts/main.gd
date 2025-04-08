class_name Main
extends Node2D

@export var load_existing_image_btn: Button


func _ready() -> void:
	var dir = DirAccess.open("user://")
	if not dir.dir_exists("drawings"):
		dir.make_dir("drawings")
		load_existing_image_btn.hide()
		return

	
	var drawings_dir = DirAccess.open("user://drawings")
	drawings_dir.list_dir_begin()
	if drawings_dir.get_files().size() == 0:
		load_existing_image_btn.hide()
		return
	else:
		load_existing_image_btn.show()
	

func _on_load_existing_image_pressed() -> void:
	var dir = DirAccess.open("user://drawings")
	dir.list_dir_begin()
	var first_file = dir.get_next()
	var drawing = SaveAndLoadManager.load_drawing(first_file.replace(".tres", ""))
	Globals.pixel_canvas = drawing
	await NumberTexturesContainer.setup()
	get_tree().change_scene_to_file("res://scenes/play.tscn")


func _on_create_from_internet_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/image_loader.tscn")

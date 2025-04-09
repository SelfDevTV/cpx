class_name Play
extends Node2D

@onready var painters: Node2D = $Painters
@export var painter_scene: PackedScene

func _ready() -> void:
	for painter in Globals.pixel_canvas.upgrades.painters:
		var new_painter = painter_scene.instantiate()
		new_painter.painter_resource = painter
		painters.add_child(new_painter)
		
	Globals.pixel_canvas.upgrades.painter_added.connect(_on_painter_added)

	%BuyTemp.text = "Add Painter: " + str(Globals.pixel_canvas.upgrades.price_painter)


func _on_button_pressed() -> void:
	SaveAndLoadManager.save_drawing(Globals.pixel_canvas, Globals.pixel_canvas.name, true)

func _on_save_interval_timeout() -> void:
	SaveAndLoadManager.save_drawing(Globals.pixel_canvas, Globals.pixel_canvas.name, true)


func _on_button_2_pressed() -> void:
	Globals.pixel_canvas.upgrades.buy_painter()

func _on_painter_added(painter_r: PainterResource) -> void:
	print("painter bought")
	var new_painter = painter_scene.instantiate() as Painter
	new_painter.painter_resource = painter_r
	painters.add_child(new_painter)
	%BuyTemp.text = "Add Painter: " + str(Globals.pixel_canvas.upgrades.price_painter)

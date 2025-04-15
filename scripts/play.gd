class_name Play
extends Node2D

@onready var painters: Node2D = $Painters
@onready var saved_notifications: Control = %GameSavedNotifications
@export var painter_scene: PackedScene
@export var save_notification_scene: PackedScene


@export var shop_ui: ShopUI


func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("open_shop"):
		shop_ui.toggle()

func _ready() -> void:
	for painter_r in Globals.pixel_canvas.upgrades.painters:
		var new_painter = painter_scene.instantiate()

		
		painters.add_child(new_painter)
		new_painter.setup(painter_r)
		
	Globals.pixel_canvas.upgrades.painter_added.connect(_on_painter_added)


func save() -> void:
	if saved_notifications.get_child_count() > 0:
		return
	SaveAndLoadManager.save_drawing(Globals.pixel_canvas, Globals.pixel_canvas.name, true)
	var new_notification = save_notification_scene.instantiate() as GameSavedNotification
	saved_notifications.add_child(new_notification)

func _on_button_pressed() -> void:
	save()

func _on_save_interval_timeout() -> void:
	save()


func _on_painter_added(painter_r: PainterResource) -> void:
	print("painter bought")
	var new_painter = painter_scene.instantiate() as Painter
	
	painters.add_child(new_painter)
	new_painter.setup(painter_r)


func _on_open_shop_pressed() -> void:
	shop_ui.toggle()

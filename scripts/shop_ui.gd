class_name ShopUI
extends Control


@onready var buy_painter_button: Button = %BuyPainter

@onready var painters_container: VBoxContainer = %Painters

@export var painter_scene: PackedScene

func _ready() -> void:
	hide()
	buy_painter_button.pressed.connect(_on_buy_painter_pressed)
	buy_painter_button.text = "Buy $" + str(Globals.pixel_canvas.upgrades.price_painter)
	Globals.pixel_canvas.upgrades.painter_added.connect(add_painter)

	for painter in Globals.pixel_canvas.upgrades.painters:
		add_painter(painter)


func toggle() -> void:
	if is_visible():
		close()
	else:
		open()


func add_painter(painter: PainterResource) -> void:
	var new_painter = painter_scene.instantiate() as PainterUpgradeUI
	painters_container.add_child(new_painter)
	new_painter.setup("Painter #" + str(painters_container.get_child_count() + 1), painter)
	
	
func open() -> void:
	show()
	get_tree().paused = true
	$AnimationPlayer.play("move_in")

func close() -> void:
	get_tree().paused = false
	$AnimationPlayer.play("move_out")
	

func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "move_out":
		hide()

func _on_buy_painter_pressed() -> void:
	if not Globals.pixel_canvas.upgrades.buy_painter():
		print("not enough credits")
	else:
		buy_painter_button.text = "Buy $" + str(Globals.pixel_canvas.upgrades.price_painter)

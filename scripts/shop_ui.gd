class_name ShopUI
extends Control


@onready var buy_painter_button: Button = %BuyPainter

func _ready() -> void:
	hide()
	buy_painter_button.pressed.connect(_on_buy_painter_pressed)


func toggle() -> void:
	if is_visible():
		close()
	else:
		open()

	
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

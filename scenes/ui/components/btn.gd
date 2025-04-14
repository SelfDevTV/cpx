@tool

class_name Btn
extends Control

var current_tween: Tween
var btn: Button

# 4px
@export var tween_amount: float = 4
@export var scale_amount: float = 1.1

func _get_configuration_warnings() -> PackedStringArray:
	if get_child_count() == 0 or get_child_count() > 1:
		return ["Requires exactly one Button as Child"]
	elif get_child(0).is_class("Button") == false:
		return ["Child must be a Button"]
	else:
		return []

func _ready() -> void:
	btn = get_child(0) as Button
	btn.mouse_entered.connect(_on_mouse_entered)
	btn.mouse_exited.connect(_on_mouse_exited)
	
	
func _on_mouse_entered() -> void:
	btn.pivot_offset.x = btn.size.x / 2
	btn.pivot_offset.y = btn.size.y / 2
	if current_tween:
		current_tween.kill()
	current_tween = create_tween()

	current_tween.tween_property(btn, "scale", Vector2.ONE * scale_amount, .1)


func _on_mouse_exited() -> void:
	btn.pivot_offset.x = btn.size.x / 2
	btn.pivot_offset.y = btn.size.y / 2
	if current_tween:
		current_tween.kill()
	current_tween = create_tween()
	current_tween.tween_property(btn, "scale", Vector2.ONE, .1)

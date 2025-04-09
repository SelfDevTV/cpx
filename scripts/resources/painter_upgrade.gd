class_name PainterUpgrade
extends Resource

@export var speed: float = 1
@export var better_ki: bool = false
@export var paint_cooldown: float = 1

func upgrade_speed() -> void:
    speed += .1

func upgrade_paint_cooldown() -> void:
    paint_cooldown -= .1

func enable_better_ki() -> void:
    better_ki = true
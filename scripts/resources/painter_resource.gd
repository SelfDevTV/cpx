class_name PainterResource
extends Resource


@export var speed: float = 1
@export var better_ki: bool = false
@export var paint_cooldown: float = 2.0
@export var credits_per_pixel_drawn = 1

var max_painter_speed: float = 10
var min_painter_cooldown: float = .1
var max_credits_per_pixel_drawn: int = 20

@export var speed_upgrade: PainterUpgrade = PainterUpgrade.new()
@export var paint_cooldown_upgrade: PainterUpgrade = PainterUpgrade.new()
@export var credits_per_pixel_upgrade: PainterUpgrade = PainterUpgrade.new()


@export var painted_pixels: Array[Vector2i]

func create() -> PainterResource:
    speed_upgrade.cost = 1
    speed_upgrade.cost_multiplier = 2

    paint_cooldown_upgrade.cost = 1
    paint_cooldown_upgrade.cost_multiplier = 2

    credits_per_pixel_upgrade.cost = 100
    credits_per_pixel_upgrade.cost_multiplier = 5

    painted_pixels = []
    return self


func upgrade_speed(credits: int) -> bool:
    if credits > speed_upgrade.cost:
        credits -= speed_upgrade.cost
        speed_upgrade.cost *= speed_upgrade.cost_multiplier
        speed += .1

        if speed > max_painter_speed:
            speed = max_painter_speed
            return false
        
        else:
            return true
    else:
        return false
   

func upgrade_paint_cooldown(credits: int) -> bool:
    if credits > paint_cooldown_upgrade.cost:
        credits -= paint_cooldown_upgrade.cost
        paint_cooldown_upgrade.cost *= paint_cooldown_upgrade.cost_multiplier
        paint_cooldown -= .1

        if paint_cooldown < min_painter_cooldown:
            paint_cooldown = min_painter_cooldown
            return false
        
        else:
            return true
    else:
        return false

func upgrade_credits_per_pixel(credits: int) -> bool:
    if credits > credits_per_pixel_upgrade.cost:
        credits -= credits_per_pixel_upgrade.cost
        credits_per_pixel_upgrade.cost *= credits_per_pixel_upgrade.cost_multiplier
        credits_per_pixel_drawn += 1

        if credits_per_pixel_drawn > max_credits_per_pixel_drawn:
            credits_per_pixel_drawn = max_credits_per_pixel_drawn
            return false
        
        else:
            return true
    else:
        return false
 

func enable_better_ki() -> void:
    better_ki = true
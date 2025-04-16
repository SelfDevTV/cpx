class_name PainterResource
extends Resource

enum PainterUpgrades {
    SPEED,
    PAINT_COOLDOWN,
    CREDITS_PER_PIXEL
}


@export var speed: float = 1
@export var better_ki: bool = false
@export var paint_cooldown: float = 2.0
@export var credits_per_pixel_drawn: int = 2

var max_painter_speed: float = 10
var min_painter_cooldown: float = .1
var max_credits_per_pixel_drawn: int = 20

@export var speed_upgrade: PainterUpgrade = PainterUpgrade.new()
@export var paint_cooldown_upgrade: PainterUpgrade = PainterUpgrade.new()
@export var credits_per_pixel_upgrade: PainterUpgrade = PainterUpgrade.new()


signal painter_upgraded(painter: PainterResource, upgrade: PainterUpgrades)


func create() -> PainterResource:
    speed_upgrade.cost = 1
    speed_upgrade.cost_multiplier = 2

    paint_cooldown_upgrade.cost = 1
    paint_cooldown_upgrade.cost_multiplier = 2

    credits_per_pixel_upgrade.cost = 100
    credits_per_pixel_upgrade.cost_multiplier = 5

    return self


func upgrade_speed(pixel_canvas: PixelCanvas) -> bool:
    if pixel_canvas.upgrades.credits >= speed_upgrade.cost and speed <= max_painter_speed:
        pixel_canvas.upgrades.credits -= speed_upgrade.cost
        speed_upgrade.cost *= speed_upgrade.cost_multiplier
        speed *= 1.5
        painter_upgraded.emit(self, PainterUpgrades.SPEED)
        return true
            
    else:
        return false
   

func upgrade_paint_cooldown(pixel_canvas: PixelCanvas) -> bool:
    if pixel_canvas.upgrades.credits >= paint_cooldown_upgrade.cost and paint_cooldown >= min_painter_cooldown:
        pixel_canvas.upgrades.credits -= paint_cooldown_upgrade.cost
        paint_cooldown_upgrade.cost *= paint_cooldown_upgrade.cost_multiplier
        paint_cooldown *= .8
        painter_upgraded.emit(self, PainterUpgrades.PAINT_COOLDOWN)
        return true
    else:
        return false

func upgrade_credits_per_pixel(pixel_canvas: PixelCanvas) -> bool:
    if pixel_canvas.upgrades.credits >= credits_per_pixel_upgrade.cost and credits_per_pixel_drawn <= max_credits_per_pixel_drawn:
        pixel_canvas.upgrades.credits -= credits_per_pixel_upgrade.cost
        credits_per_pixel_upgrade.cost *= credits_per_pixel_upgrade.cost_multiplier
        credits_per_pixel_drawn += 1
        painter_upgraded.emit(self, PainterUpgrades.CREDITS_PER_PIXEL)
        return true
    else:
        return false
 

func enable_better_ki() -> void:
    better_ki = true

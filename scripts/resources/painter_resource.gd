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


func upgrade_speed(credits: int) -> bool:
    if credits > speed_upgrade.cost:
        credits -= speed_upgrade.cost
        speed_upgrade.cost *= speed_upgrade.cost_multiplier
        speed *= 1.5

        if speed > max_painter_speed:
            speed = max_painter_speed
            return false
        
        else:
            painter_upgraded.emit(self, PainterUpgrades.SPEED)
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
            painter_upgraded.emit(self, PainterUpgrades.PAINT_COOLDOWN)
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
            painter_upgraded.emit(self, PainterUpgrades.CREDITS_PER_PIXEL)
            return true
    else:
        return false
 

func enable_better_ki() -> void:
    better_ki = true
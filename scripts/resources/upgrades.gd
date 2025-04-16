class_name Upgrades
extends Resource

enum PainterUpgrades {
    SPEED,
    PAINT_COOLDOWN,
    CREDITS_PER_PIXEL
}

var max_painters: int = 20
@export var price_painter: int = 10
@export var price_painter_multiplier: int = 2

@export var credits: int = 10
@export var painters: Array[PainterResource] = []

signal painter_added(painter_r: PainterResource)
signal update_bought

func init_painter_signals() -> void:
	# Connect the painter_upgraded signal for each painter
	for painter in painters:
		painter.painter_upgraded.connect(func(_new_painter: PainterResource, _upgrade: PainterUpgrades): update_bought.emit())


func buy_painter() -> bool:
	if credits < price_painter:
		return false
	if painters.size() < max_painters:
		var painter = PainterResource.new().create()
		painter.painter_upgraded.connect(func(_new_painter: PainterResource, _upgrade: PainterUpgrades): update_bought.emit())
		painters.append(painter)
		
		credits -= price_painter
		price_painter *= price_painter_multiplier
		painter_added.emit(painter)
		
		return true
	else:
		return false

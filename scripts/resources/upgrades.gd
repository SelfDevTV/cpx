class_name Upgrades
extends Resource


var max_painters: int = 20
@export var price_painter: int = 10
@export var price_painter_multiplier: int = 3

@export var credits: int = 0
@export var painters: Array[PainterResource] = []

signal painter_added(painter_r: PainterResource)

func buy_painter() -> bool:
	if credits < price_painter:
		return false
	if painters.size() < max_painters:
		var painter = PainterResource.new().create()
		painters.append(painter)
		
		credits -= price_painter
		price_painter *= price_painter_multiplier
		painter_added.emit(painter)
		return true
	else:
		return false

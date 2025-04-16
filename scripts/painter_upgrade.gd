class_name PainterUpgradeUI
extends PanelContainer

@onready var speed_upgr_btn = %SpeedUpgr
@onready var cd_upgr_btn = %CooldownUpgr
@onready var credits_upgr_btn = %CreditsUpgr

var painter_r: PainterResource


func setup(title: String, new_painter_r: PainterResource) -> void:
    painter_r = new_painter_r
    %Title.text = title
    update_button_text()

    
func update_button_text() -> void:
    speed_upgr_btn.text = "Speed $" + str(painter_r.speed_upgrade.cost)
    cd_upgr_btn.text = "Cooldown $" + str(painter_r.paint_cooldown_upgrade.cost)
    credits_upgr_btn.text = "Credits/p $" + str(painter_r.credits_per_pixel_upgrade.cost)


func _on_credits_upgr_pressed() -> void:
    painter_r.upgrade_credits_per_pixel(Globals.pixel_canvas)
    update_button_text()


func _on_cooldown_upgr_pressed() -> void:
    painter_r.upgrade_paint_cooldown(Globals.pixel_canvas)
    update_button_text()

func _on_speed_upgr_pressed() -> void:
    painter_r.upgrade_speed(Globals.pixel_canvas)
    update_button_text()

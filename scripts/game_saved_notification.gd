class_name GameSavedNotification
extends PanelContainer

func _ready() -> void:
	$AnimationPlayer.play("move_in")


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "move_in":
		$Timer.start()

func _on_timer_timeout() -> void:
	$AnimationPlayer.play("move_out")
	await $AnimationPlayer.animation_finished
	queue_free()

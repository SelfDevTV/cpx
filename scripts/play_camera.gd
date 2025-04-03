class_name PlayCamera
extends Camera2D

@export var move_speed := 300 # Speed of camera movement

func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_WHEEL_UP and event.pressed:
			if zoom >= Vector2(2.0, 2.0):
				return
			var mouse_pos = get_global_mouse_position()
			var zoom_factor = 1.1
			zoom *= zoom_factor
			position += (mouse_pos - position) * (1 - 1 / zoom_factor)
		elif event.button_index == MOUSE_BUTTON_WHEEL_DOWN and event.pressed:
			if zoom <= Vector2(0.8, 0.8):
				return
			var mouse_pos = get_global_mouse_position()
			var zoom_factor = 0.9
			zoom *= zoom_factor
			position += (mouse_pos - position) * (1 - 1 / zoom_factor)

	zoom.x = clamp(zoom.x, 0.8, 2.0)
	zoom.y = clamp(zoom.y, 0.8, 2.0)

func _process(delta):
	var direction := Vector2.ZERO

	if Input.is_action_pressed("cam_move_up"): # W key
		direction.y -= 1
	if Input.is_action_pressed("cam_move_down"): # S key
		direction.y += 1
	if Input.is_action_pressed("cam_move_left"): # A key
		direction.x -= 1
	if Input.is_action_pressed("cam_move_right"): # D key
		direction.x += 1

	position += direction.normalized() * move_speed * delta

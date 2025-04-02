class_name PlayCamera
extends Camera2D

@export var move_speed := 300 # Speed of camera movement

func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_WHEEL_UP and event.pressed:
			zoom *= 1.1
		elif event.button_index == MOUSE_BUTTON_WHEEL_DOWN and event.pressed:
			zoom *= 0.9

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

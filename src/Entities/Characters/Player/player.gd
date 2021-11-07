extends "res://src/Entities/Characters/character.gd"

func _input(event):
	var mouse_pos = get_global_mouse_position()
	if event.is_action_pressed("attack") and state != ATTACK:
		#_change_state(ATTACK)
		var attack_dir = rad2deg((mouse_pos - self.global_position).normalized().angle())
		$"Node2D".attack(attack_dir)
		
		
	if event is InputEventMouseMotion:
		
		### Camera Movement
		var mouse_offset = (get_viewport().get_mouse_position() - get_viewport().size / 2)
		# Setting some boundaries
		if mouse_offset.x > 400:
			mouse_offset.x = 400
		if mouse_offset.x < -400:
			mouse_offset.x = -400
		if mouse_offset.y > 200:
			mouse_offset.y = 200
		if mouse_offset.y < -200:
			mouse_offset.y = -200
		$Camera2D.position = lerp(Vector2(), mouse_offset.normalized() * 500, mouse_offset.length() / 1000)
		
		# Debug
	
		emit_signal("look_changed", mouse_pos)
		
func _physics_process(delta):
	input_direction = Vector2()
	input_direction.x = int(Input.is_action_pressed("move_right")) - int(Input.is_action_pressed("move_left"))
	input_direction.y = int(Input.is_action_pressed("move_down")) - int(Input.is_action_pressed("move_up"))
	
	if input_direction and input_direction != last_move_direction:
		emit_signal("direction_changed", input_direction)

	move_and_slide(input_direction * 100)

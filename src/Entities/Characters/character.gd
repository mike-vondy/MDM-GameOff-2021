extends KinematicBody2D

signal state_changed
signal direction_changed
signal look_changed

var input_direction = Vector2()
var look_direction = Vector2(1,0)
var last_move_direction = Vector2(1,0)

enum {IDLE, ATTACK}
var state = null

func _ready():
	_change_state(IDLE)

func _change_state(new_state):
	match new_state:
		IDLE:
			print("Character: IDLE")
	state = new_state
	emit_signal('state_changed', new_state)
	
func _physics_process(delta):
	if not input_direction:
		return
	
	last_move_direction = input_direction
	if input_direction.x in [-1, 1]:
		look_direction.x = input_direction.x
		$BodyPivot.set_scale(Vector2(look_direction.x, 1))
		
	move_and_slide(input_direction)

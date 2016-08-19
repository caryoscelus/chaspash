# PCShip

extends RigidBody2D

var direction = Vector2(0, 0)
var speed = 100

const ACTIONS = {
	move_up = Vector2(0, -1),
	move_right = Vector2(1, 0),
	move_down = Vector2(0, 1),
	move_left = Vector2(-1, 0),
}

func _ready():
	set_process_input(true)

func _input(event):
	for action in ACTIONS:
		if event.is_action_pressed(action):
			direction += ACTIONS[action]
		elif event.is_action_released(action):
			direction -= ACTIONS[action]
	_update_velocity()

func _update_velocity():
	self.set_linear_velocity(direction*speed)

func _on_body_enter(body):
	pass

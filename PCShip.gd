# PCShip

extends RigidBody2D

var direction = Vector2(0, 0)
var speed = 100
const Bullet = preload("Bullet.tscn")

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
	if event.is_action_pressed("shoot"):
		shoot_once()
		start_shooting()
	elif event.is_action_released("shoot"):
		stop_shooting()

func _update_velocity():
	set_linear_velocity(direction*speed)

func _on_body_enter(body):
	pass

func shoot_once():
	var bullet = Bullet.instance()
	bullet.owner = self
	bullet.set_pos(get_pos())
	bullet.set_linear_velocity(Vector2(bullet.speed, 0))
	get_node("..").add_child(bullet)

func start_shooting():
	get_node("shoot_timer").start()

func stop_shooting():
	get_node("shoot_timer").stop()

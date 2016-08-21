# PCShip

extends RigidBody2D

signal hurt
signal end_of_level

const Bullet = preload("Bullet.tscn")

onready var gunpoint = get_node("gunpoint")
onready var shape = get_node("shape")
onready var sprites = get_node("sprites")

export var WIDTH = 40
export var speed = 200
export var maxhp = 3
var hp setget set_hp
var direction = Vector2(0, 0)
const team = "player"

const ACTIONS = {
	move_up = Vector2(0, -1),
	move_right = Vector2(1, 0),
	move_down = Vector2(0, 1),
	move_left = Vector2(-1, 0),
}

func _ready():
	set_hp(3)
	set_process_input(true)

func _input(event):
	direction = Vector2(0, 0)
	for action in ACTIONS:
		if Input.is_action_pressed(action):
			direction += ACTIONS[action]
	_update_velocity()
	if event.is_action_pressed("shoot"):
		shoot_once()
		start_shooting()
	elif event.is_action_released("shoot"):
		stop_shooting()

func _update_velocity():
	set_linear_velocity(direction*speed)

func _on_body_enter(body):
	if "owner" in body and body.owner == self:
		return
	if body == get_node("../borders"):
		return
	emit_signal("hurt")

func _on_hurt():
	self.hp -= 1
	if hp <= 0:
		get_node("..").emit_signal("game_over")
		queue_free()

func set_hp(new_hp):
	if hp == new_hp:
		return
	hp = new_hp
	var sprite = get_node("sprites/sprite")
	for s in sprites.get_children():
		if s != sprite:
			s.queue_free()
	for i in range(hp-1):
		sprite = sprite.duplicate()
		sprite.set_offset(sprite.get_offset()+Vector2(WIDTH, 0))
		sprites.add_child(sprite)
	gunpoint.set_pos(Vector2(hp*WIDTH, 0))
	shape.set_pos(Vector2((hp-1)*WIDTH/2.0, 0))
	shape.set_scale(Vector2(hp*2.0/3+1.0/3, 1))

func shoot_once():
	var bullet = Bullet.instance()
	bullet.owner = self
	bullet.team = team
	bullet.set_pos(get_pos()+gunpoint.get_pos())
	bullet.set_linear_velocity(Vector2(bullet.speed, 0))
	get_node("..").add_child(bullet)
	PlayerInfo.shot_bullet(bullet)

func start_shooting():
	get_node("shoot_timer").start()

func stop_shooting():
	get_node("shoot_timer").stop()

func _on_end_of_level():
	get_node("..").emit_signal("change_level")

# gun
extends Node2D

const Bullet = preload("res://Bullet.tscn")

onready var shoot_delay = get_node("shoot_delay")
onready var gunpoint = get_node("gunpoint")
onready var view = get_node("view")
onready var owner = get_node("..")
onready var bullets = owner.get_node("bullets")

var reloading = false
var team = "enemy"

func _ready():
	set_fixed_process(true)

func _fixed_process(dt):
	if reloading:
		return
	if view.is_colliding():
		var target = view.get_collider()
		if target and target.team != owner.team:
			shoot_once()

func shoot_once():
	var bullet = Bullet.instance()
	bullet.owner = owner
	bullet.team = owner.team
	bullet.set_pos(owner.get_pos()+gunpoint.get_pos())
	bullet.set_linear_velocity(Vector2(-bullet.speed, 0))
	bullets.add_child(bullet)
	reloading = true
	shoot_delay.start()

func _on_reload_complete():
	reloading = false

# Space

extends Area2D

signal change_level
signal game_over

var velocity = 100
var moving = true

func _ready():
	set_fixed_process(true)

func _fixed_process(dt):
	if moving:
		set_pos(get_pos()+Vector2(velocity*dt, 0))

func _on_body_enter(body):
	body.emit_signal("enter_space_area")

func _on_body_exit(body):
	body.emit_signal("left_space_area")

func stop():
	set_linear_damp(2.0)
	moving = false

# Space

extends Area2D

var velocity = 100

func _ready():
	set_fixed_process(true)

func _fixed_process(dt):
	set_pos(get_pos()+Vector2(velocity*dt, 0))

func _on_body_exit(body):
	body.emit_signal("left_space_area")

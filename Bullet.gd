# Bullet

extends RigidBody2D

export var speed = 300
var owner

func _on_body_enter(body):
	if body != owner:
		queue_free()

# Bullet

extends RigidBody2D

export var speed = 300
export var shot_score = 1
var owner
var team

signal left_space_area

func _on_body_enter(body):
	if body != owner:
		queue_free()

func _on_left_space_area():
	queue_free()

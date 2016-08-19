# base enemy

extends RigidBody2D

func _ready():
	#set_fixed_process(true)
	pass

func _on_body_enter(body):
	queue_free()

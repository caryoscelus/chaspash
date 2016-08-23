# globals shader
extends CanvasLayer

onready var root = get_node("/root")

func _ready():
	SceneTransition.connect("changed_scene", self, "raise_me")
	raise_me()

func raise_me():
	call_deferred("raise")

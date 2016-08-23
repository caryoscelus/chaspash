#
extends CanvasLayer

signal changed_scene

onready var viewport = get_node("/root")
onready var old = get_node("old")
onready var animation = get_node("animation")

func change_scene(scene):
	viewport.queue_screen_capture()
	yield(get_tree(), "idle_frame")
	yield(get_tree(), "idle_frame")
	var image = viewport.get_screen_capture()
	var texture = ImageTexture.new()
	texture.create_from_image(image)
	old.set_texture(texture)
	get_tree().change_scene(scene)
	animation.play("fadeout")
	emit_signal("changed_scene")

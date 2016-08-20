# scene transition
extends Container

export(String, FILE, "*.tscn") var initial_scene
export var is_main_view = true

onready var old_wrapper = get_node("old")
onready var new_wrapper = get_node("new")
onready var old = get_node("old/container")
onready var new = get_node("new/container")
onready var animation = get_node("animation")
onready var sceneman = get_node("/root/SceneManager")

func _ready():
	if is_main_view:
		sceneman.connect("change_scene", self, "change_scene")
	change_scene(initial_scene)

func change_scene(node):
	if typeof(node) == TYPE_STRING:
		node = load(node).instance()
	call_deferred("_do_load_node", node)

func _do_load_node(node):
	print("will set node ", node)
	for child in old.get_children():
		child.queue_free()
	for child in new.get_children():
		old.add_child(child)
		new.remove_child(child)
	new.add_child(node)
	print("will play animation")
	animation.play("crossfade")

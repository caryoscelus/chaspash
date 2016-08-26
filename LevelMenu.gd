# Level menu
extends GridContainer

export var levels = StringArray()

var first = 0

func _ready():
	update_scroll()
	get_node("button0").grab_focus()

func update_scroll():
	for i in range(4):
		var lvl = first+i
		var button = get_node("button"+str(i))
		if lvl < levels.size():
			button.connect("pressed", self, "go_level", [lvl])
			button.get_node("label").set_text("level "+str(lvl))
		else:
			button.get_node("label").set_text("")

func go_level(n):
	if levels.size() <= n:
		return
	SceneTransition.change_scene(levels[n])

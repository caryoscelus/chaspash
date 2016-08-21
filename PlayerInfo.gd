# global player info
extends Node

signal score_changed(score)
signal max_score_changed(max_score)

var score = 0 setget set_score
onready var max_score = load_score()

func set_score(new_score):
	score = new_score
	if score > max_score:
		save_score(score)
	emit_signal("score_changed", score)

func killed_enemy(enemy):
	self.score += enemy.kill_score

func missed_enemy(enemy):
	self.score -= enemy.miss_score

func shot_bullet(bullet):
	self.score -= bullet.shot_score

func load_score():
	var file = File.new()
	var new_score = 0
	if file.file_exists("user://score.sav"):
		file.open("user://score.sav", File.READ)
		new_score = int(file.get_line())
		file.close()
	emit_signal("max_score_changed", new_score)
	return new_score

func save_score(new_score):
	max_score = new_score
	var file = File.new()
	file.open("user://score.sav", File.WRITE)
	file.store_line(str(new_score))
	file.close()
	emit_signal("max_score_changed", new_score)

func restart():
	score = 0

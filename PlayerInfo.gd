# global player info
extends Node

signal score_changed(score)

var score = 0 setget set_score

func set_score(new_score):
	score = new_score
	emit_signal("score_changed", score)

func killed_enemy(enemy):
	self.score += 1

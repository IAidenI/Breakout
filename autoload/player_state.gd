extends Node

signal lives_changed(lives: int)

const MAX_LIVES := 3

var lives := MAX_LIVES:
	set(value):
		lives = value
		lives_changed.emit(lives)

var score := 0
var completed_levels: Array[int] = []

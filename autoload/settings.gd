extends Node

signal move_mode_changed(move_mode: MoveMode)

enum MoveMode { MOUSE, KEYBOARD }

var move_mode :MoveMode = MoveMode.MOUSE:
	set(value):
		move_mode = value
		move_mode_changed.emit(move_mode)

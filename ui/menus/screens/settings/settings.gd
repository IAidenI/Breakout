class_name SettingsMenu
extends Control

signal closed

func _ready() -> void:
	if Settings.move_mode == Settings.MoveMode.MOUSE:
		$SettingsPanel/VBoxContainer/HBoxContainer/CheckButton.button_pressed = false
	elif Settings.move_mode == Settings.MoveMode.KEYBOARD:
		$SettingsPanel/VBoxContainer/HBoxContainer/CheckButton.button_pressed = true

func _on_check_button_toggled(toggled_on: bool) -> void:
	Settings.move_mode = Settings.MoveMode.KEYBOARD if toggled_on else Settings.MoveMode.MOUSE

func _on_back_button_pressed() -> void:
	closed.emit()

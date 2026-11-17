class_name GameOver
extends Control

signal retry_requested
signal main_menu_requested

var level :LevelData

func _on_retry_button_pressed() -> void:
	retry_requested.emit()

func _on_main_menu_button_pressed() -> void:
	main_menu_requested.emit()

func _on_exit_pressed() -> void:
	get_tree().quit()

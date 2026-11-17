class_name Victory
extends Control

signal new_game_requested
signal main_menu_requested

func _on_new_game_button_pressed() -> void:
	new_game_requested.emit()

func _on_main_menu_button_pressed() -> void:
	main_menu_requested.emit()

func _on_exit_button_pressed() -> void:
	get_tree().quit()

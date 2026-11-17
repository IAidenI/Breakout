class_name Pause
extends Control

signal main_menu_requested

func _on_resume_pressed() -> void:
	get_tree().paused = false
	visible = get_tree().paused

func _on_exit_pressed() -> void:
	get_tree().quit()

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("pause"):
		get_tree().paused = not get_tree().paused
		visible = get_tree().paused
		get_viewport().set_input_as_handled()

func _on_main_menu_button_pressed() -> void:
	main_menu_requested.emit()

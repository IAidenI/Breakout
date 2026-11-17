class_name Pause
extends Control

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

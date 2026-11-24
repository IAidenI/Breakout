class_name Pause
extends Control

signal main_menu_requested
signal retry_requested

func _ready() -> void:
	$Settings.closed.connect(_on_settings_closed)

func _on_resume_pressed() -> void:
	pause()

func _on_retry_button_pressed() -> void:
	retry_requested.emit()

func _on_settings_button_pressed() -> void:
	$PausePanel.hide()
	$Settings.show()

func _on_main_menu_button_pressed() -> void:
	main_menu_requested.emit()

func _on_exit_pressed() -> void:
	get_tree().quit()

func _unhandled_input(event: InputEvent) -> void:
	if not event.is_action_pressed("pause"):
		return
	
	if $Settings.visible:
		_on_settings_closed()
	else:
		pause()
	get_viewport().set_input_as_handled()

func pause() -> void:
	get_tree().paused = not get_tree().paused
	visible = get_tree().paused
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE if get_tree().paused else Input.MOUSE_MODE_HIDDEN

func _on_settings_closed() -> void:
	$PausePanel.show()
	$Settings.hide()

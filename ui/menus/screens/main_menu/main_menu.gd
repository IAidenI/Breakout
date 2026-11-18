class_name MainMenu
extends Control

func _ready() -> void:
	$Settings.closed.connect(_on_settings_closed)

func _on_new_game_pressed() -> void:
	PlayerState.reset()
	SceneManager.goto("level_selector")

func _on_settings_pressed() -> void:
	$Settings.show()
	$MainMenuPanel.hide()

func _on_exit_pressed() -> void:
	get_tree().quit()

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("pause"):
		_on_settings_closed()

func _on_settings_closed() -> void:
	$Settings.hide()
	$MainMenuPanel.show()

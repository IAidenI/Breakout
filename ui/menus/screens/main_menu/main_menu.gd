class_name MainMenu
extends Control

func _on_new_game_pressed() -> void:
	PlayerState.reset()
	SceneManager.goto("level_selector")

func _on_exit_pressed() -> void:
	get_tree().quit()

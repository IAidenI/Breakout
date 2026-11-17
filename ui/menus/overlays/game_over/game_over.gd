class_name GameOver
extends Control

func _on_new_game_pressed() -> void:
	PlayerState.reset()
	SceneManager.goto("game")

func _on_exit_pressed() -> void:
	get_tree().quit()

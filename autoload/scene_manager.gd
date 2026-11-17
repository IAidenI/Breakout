extends Node

const SCENES := {
	"main_menu": "res://ui/menus/main_menu/main_menu.tscn",
	"game": "res://game/game.tscn"
}

func goto(scene_name: String) -> void:
	if not SCENES.has(scene_name):
		print("Scène %s inconnue.", scene_name)
		return
	get_tree().paused = false
	get_tree().change_scene_to_file(SCENES[scene_name])

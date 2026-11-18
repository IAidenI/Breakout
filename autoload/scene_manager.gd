extends Node

const SCENES := {
	"main_menu": "res://ui/menus/screens/main_menu/main_menu.tscn",
	"game": "res://game/game.tscn",
	"level_selector": "res://ui/menus/screens/level_select/level_select.tscn",
	"settings": "res://ui/menus/screens/settings/settings.tscn"
}
var _params := {}

func goto(scene_name: String, params := {}) -> void:
	_params = params
	if not SCENES.has(scene_name):
		print("Scène %s inconnue.", scene_name)
		return
	get_tree().paused = false
	get_tree().change_scene_to_file(SCENES[scene_name])

func get_param(key :String):
	return _params.get(key)

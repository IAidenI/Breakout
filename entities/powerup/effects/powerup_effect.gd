class_name PowerUpEffect
extends Resource

enum Slot { NONE, SIZE, FIRE }
@export var icon         :Texture2D
@export var display_name := ""
@export var duration     := 0.0
@export var slot         := Slot.NONE

func apply(_game: Game) -> void:
	pass   # Chaque effet réécrit cette fonction

func remove(_game: Game) -> void:
	pass

func is_available() -> bool:
	return true # Par défaut, un effet est toujours disponible

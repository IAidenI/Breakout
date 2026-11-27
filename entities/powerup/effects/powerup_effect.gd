class_name PowerUpEffect
extends Resource

@export var color :Color
@export var label :String

func apply(_game: Game) -> void:
	pass   # Chaque effet réécrit cette fonction

func is_available() -> bool:
	return true # Par défaut, un effet est toujours disponible

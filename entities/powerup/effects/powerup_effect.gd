class_name PowerUpEffect
extends Resource

@export var icon :Texture2D

func apply(_game: Game) -> void:
	pass   # Chaque effet réécrit cette fonction

func is_available() -> bool:
	return true # Par défaut, un effet est toujours disponible

class_name FireEffect
extends PowerUpEffect

@export var duration :float = 7.0

func apply(game: Game) -> void:
	game.balls.fire_all(duration)

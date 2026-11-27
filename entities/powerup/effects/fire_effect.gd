class_name FireEffect
extends PowerUpEffect

func apply(game: Game) -> void:
	game.balls.set_fire(true)

func remove(game: Game) -> void:
	game.balls.set_fire(false)

class_name LifeEffect
extends PowerUpEffect

func apply(_game: Game) -> void:
	PlayerState.lives += 1

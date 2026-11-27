class_name LifeEffect
extends PowerUpEffect

func apply(_game: Game) -> void:
	PlayerState.lives += 1

func is_available() -> bool:
	return PlayerState.lives < PlayerState.MAX_LIVES

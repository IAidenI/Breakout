class_name ResizePaddleEffect
extends PowerUpEffect

@export var shape: Paddle.Shape = Paddle.Shape.LARGE
@export var duration :float = 15.0

func apply(game: Game) -> void:
	game.paddle.resize(shape, duration)

class_name ResizePaddleEffect
extends PowerUpEffect

@export var shape: Paddle.Shape = Paddle.Shape.NORMAL

func apply(game: Game) -> void:
	game.paddle.resize(shape)

func remove(game: Game) -> void:
	game.paddle.resize(Paddle.Shape.NORMAL)

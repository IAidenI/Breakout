class_name Brick
extends StaticBody2D

const MAX_HP :int = 3
var hp :int = MAX_HP

func hit() -> void:
	hp -= 1
	if hp <= 0:
		queue_free()
	else:
		$Sprite2D.frame = MAX_HP - hp

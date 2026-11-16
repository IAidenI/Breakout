class_name Main
extends Node2D

@export var level: LevelData

func _ready() -> void:
	if not level.validate_level():
		print("Une erreur à été détecté dans le niveau.")
		return
	$Bricks.build(level)

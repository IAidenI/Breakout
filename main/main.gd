class_name Main
extends Node2D

@export var level: LevelData
const TOP_MARGIN := 50.0

func _ready() -> void:
	if not level.validate_level():
		print("Une erreur à été détecté dans le niveau.")
		return
	var level_size :Vector2 = $Bricks.build(level) * $Bricks.scale
	
	# Repositionnement du niveau pour le centrer
	$Bricks.position.x = (get_viewport_rect().size.x - level_size.x) / 2
	$Bricks.position.y = TOP_MARGIN

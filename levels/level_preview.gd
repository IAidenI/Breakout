@tool
class_name LevelPreview
extends Node2D

const TOP_MARGIN := 50.0

@export var level: LevelData:
	set(value):
		level = value
		if is_node_ready():
			refresh()

func _ready() -> void:
	refresh()

func refresh() -> void:
	$Bricks.clear()
	
	# Crée le niveau et en vérifiant les erreurs
	if not level.validate_level():
		print("Une erreur à été détecté dans le niveau.")
		return
	
	var level_size :Vector2 = $Bricks.build(level) * $Bricks.scale
	
	# Repositionnement du niveau pour le centrer
	$Bricks.position.x = (get_viewport_rect().size.x - level_size.x) / 2
	$Bricks.position.y = TOP_MARGIN

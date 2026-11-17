@tool
class_name LevelPreview
extends Node2D

@export var fit_to_viewport := false
@export var level: LevelData:
	set(value):
		level = value
		if is_node_ready():
			refresh()

const TOP_MARGIN := 50.0

func _ready() -> void:
	refresh()

func refresh() -> void:
	$Bricks.clear()
	
	# Pas encore de niveau : rien à afficher, ce n'est pas une erreur
	if level == null:
		return
	
	# Crée le niveau et en vérifiant les erreurs
	if not level.validate_level():
		print("Une erreur à été détecté dans le niveau.")
		return
	
	var level_size :Vector2 = $Bricks.build(level)
	
	if fit_to_viewport:
		# Miniature : réduit le niveau pour remplir le viewport
		var view_size :Vector2 = get_viewport_rect().size
		var s :float = minf(view_size.x / level_size.x, view_size.y / level_size.y)
		$Bricks.scale = Vector2(s, s)
		$Bricks.position = (view_size - level_size * s) / 2
	else:
		# Taille réelle : placé comme en jeu
		var screen_width :float = ProjectSettings.get_setting("display/window/size/viewport_width")
		var real_width   :float = level_size.x * $Bricks.scale.x
		$Bricks.position = Vector2((screen_width - real_width) / 2, TOP_MARGIN)
	$Arena.visible = not fit_to_viewport

class_name Main
extends Node2D

@export var level: LevelData
const TOP_MARGIN := 50.0

func _ready() -> void:
	# Crée le niveau et en vérifiant les erreurs
	if not level.validate_level():
		print("Une erreur à été détecté dans le niveau.")
		return
	var level_size :Vector2 = $Bricks.build(level) * $Bricks.scale
	
	# Repositionnement du niveau pour le centrer
	$Bricks.position.x = (get_viewport_rect().size.x - level_size.x) / 2
	$Bricks.position.y = TOP_MARGIN
	
	# Se connecte au signal de la deadzone
	$Arena/Deadzone.body_entered.connect(_on_deadzone_body_entered)
	
	# Fait apparaitre une balle
	_respawn_ball()
	
	# Ecoute si le niveau est terminé ou non
	$Bricks.level_cleared.connect(_on_level_cleared)

func _respawn_ball() -> void:
	var paddle_pos: Vector2 = $Arena/Paddle.global_position
	$Arena/Ball.respawn(paddle_pos + Vector2(0, -20))

func _on_deadzone_body_entered(body: Node2D) -> void:
	if body is not Ball:
		return
	
	# Supprime une vie si la deadzone est atteinte par la balle
	PlayerState.lives -= 1
	if PlayerState.lives > 0:
		print("Vies restante : ", PlayerState.lives)
		_respawn_ball()
	else:
		$CanvasLayer/GameOver.visible = true
		get_tree().paused = true

func _on_level_cleared() -> void:
	$CanvasLayer/Victory.visible = true
	get_tree().paused = true

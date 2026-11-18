class_name Game
extends Node2D

@export var level: LevelData
const TOP_MARGIN := 50.0

func _ready() -> void:
	var chosen :LevelData = SceneManager.get_param("level")
	if chosen:
		level = chosen
	
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
	
	# Ecoute les demandes des menus
	$CanvasLayer/GameOver.retry_requested.connect(_on_retry_requested)
	$CanvasLayer/GameOver.main_menu_requested.connect(_on_main_menu_requested)
	$CanvasLayer/Victory.new_game_requested.connect(_on_new_game_requested)
	$CanvasLayer/Victory.main_menu_requested.connect(_on_main_menu_requested)
	$CanvasLayer/Pause.main_menu_requested.connect(_on_main_menu_requested)
	
	Input.mouse_mode = Input.MOUSE_MODE_HIDDEN

func _respawn_ball() -> void:
	var paddle_pos: Vector2 = $Arena/Paddle.global_position
	$Arena/Ball.respawn(paddle_pos + Vector2(0, -20))

func _on_deadzone_body_entered(body: Node2D) -> void:
	if body is not Ball:
		return
	
	# Supprime une vie si la deadzone est atteinte par la balle
	PlayerState.lives -= 1
	if PlayerState.lives > 0:
		_respawn_ball()
	else:
		end_game($CanvasLayer/GameOver)

func _on_level_cleared() -> void:
	end_game($CanvasLayer/Victory)

func end_game(screen: Control) -> void:
	screen.visible = true
	$CanvasLayer/Pause.set_process_unhandled_input(false)
	get_tree().paused = true

func _on_retry_requested() -> void:
	PlayerState.reset()
	SceneManager.goto("game", { "level": level })

func _on_main_menu_requested() -> void:
	SceneManager.goto("main_menu")

func _on_new_game_requested() -> void:
	PlayerState.reset()
	SceneManager.goto("level_selector")

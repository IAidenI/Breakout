class_name Game
extends Node2D

@export var level: LevelData
const TOP_MARGIN := 50.0

const POWERUP_SCENE := preload("res://entities/powerup/powerup.tscn")
const POWERUP_RATE :float = 1.0
@export var powerup_effects :Array[PowerUpEffect]

@onready var balls  :BallManager = $Balls
@onready var paddle :Paddle = $Arena/Paddle

func _ready() -> void:
	# Récupère le niveau à charger
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
	$Balls.spawn_on(paddle)
	
	# Ecoute si le niveau est terminé ou non
	$Bricks.level_cleared.connect(_on_level_cleared)
	
	# Ecoute les powerups
	$Bricks.brick_destroyed.connect(_on_brick_destroyed)
	
	# Ecoute les demandes des menus
	$CanvasLayer/GameOver.retry_requested.connect(_on_retry_requested)
	$CanvasLayer/GameOver.main_menu_requested.connect(_on_main_menu_requested)
	$CanvasLayer/Victory.new_game_requested.connect(_on_new_game_requested)
	$CanvasLayer/Victory.main_menu_requested.connect(_on_main_menu_requested)
	$CanvasLayer/Pause.main_menu_requested.connect(_on_main_menu_requested)
	$CanvasLayer/Pause.retry_requested.connect(_on_retry_requested)
	
	Input.mouse_mode = Input.MOUSE_MODE_HIDDEN

func _unhandled_input(event: InputEvent) -> void:
	var action := "launch_mouse" if Settings.move_mode == Settings.MoveMode.MOUSE else "launch_keyboard"
	if event.is_action_pressed(action):
		$Balls.launch_all()

func _on_deadzone_body_entered(body: Node2D) -> void:
	if body is not Ball:
		return
	
	# Détruit la balle
	body.queue_free()
	
	# Ne fait rien si il reste des balles
	if $Balls.count_remaining(body) > 0:
		return
	
	# Enlève une vie si il n'en reste plus
	PlayerState.lives -= 1
	if PlayerState.lives > 0:
		pass
		$Balls.spawn_on(paddle)
	else:
		end_game($CanvasLayer/GameOver)

func _on_level_cleared() -> void:
	end_game($CanvasLayer/Victory)

func end_game(screen: Control) -> void:
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	screen.visible = true
	$CanvasLayer/Pause.set_process_unhandled_input(false)
	get_tree().paused = true

func _on_brick_destroyed(at: Vector2) -> void:
	if randf() < POWERUP_RATE:
		spawn_powerup(at)

func spawn_powerup(at: Vector2) -> void:
	var powerup :PowerUp = POWERUP_SCENE.instantiate()
	powerup.effect = powerup_effects.pick_random()
	powerup.global_position = at
	powerup.collected.connect(_on_powerup_collected)
	$PowerUps.add_child.call_deferred(powerup)

func _on_powerup_collected(effect: PowerUpEffect) -> void:
	effect.apply(self)

func _on_retry_requested() -> void:
	PlayerState.reset()
	SceneManager.goto("game", { "level": level })

func _on_main_menu_requested() -> void:
	SceneManager.goto("main_menu")

func _on_new_game_requested() -> void:
	PlayerState.reset()
	SceneManager.goto("level_selector")

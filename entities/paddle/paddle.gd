class_name Paddle
extends CharacterBody2D

const SPEED = 300.0
var _move_mode :Settings.MoveMode

func _ready() -> void:
	position.x = get_viewport_rect().size.x / 2
	position.y = get_viewport_rect().size.y * 3 / 4 # 1/4 de l'écran en partant du bas
	
	_move_mode = Settings.move_mode
	
	# Ecoute le mode de déplacement choisit
	Settings.move_mode_changed.connect(_on_mode_changed)

func _physics_process(delta: float) -> void:
	if _move_mode == Settings.MoveMode.MOUSE:
		mouse(delta)
	elif _move_mode == Settings.MoveMode.KEYBOARD:
		keyboard()

func get_half_width() -> float:
	return $Hitbox.shape.size.x / 2 * scale.x

func keyboard() -> void:
	var direction := Input.get_axis("move_left", "move_right")
	velocity.x = direction * SPEED
	move_and_slide()

func mouse(delta: float) -> void:
	var mouse_pos_x :float = get_global_mouse_position().x
	velocity.x = (mouse_pos_x - global_position.x) / delta
	move_and_slide()

func _on_mode_changed(move_mode: Settings.MoveMode) -> void:
	_move_mode = move_mode

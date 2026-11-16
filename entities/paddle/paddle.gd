class_name Paddle
extends CharacterBody2D

const SPEED = 200.0

func _ready() -> void:
	position.x = get_viewport_rect().size.x / 2
	position.y = get_viewport_rect().size.y * 3 / 4 # 1/4 de l'écran en partant du bas

func _physics_process(delta: float) -> void:
	var direction := Input.get_axis("ui_left", "ui_right")
	velocity.x = direction * SPEED
	move_and_slide()

func get_half_width() -> float:
	return $Hitbox.shape.size.x / 2 * scale.x

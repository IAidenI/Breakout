class_name Ball
extends CharacterBody2D

const LAUNCH_ANGLE := 10.0

const SPEED :float = 200.0
const MAX_BOUNCE_ANGLE :float = 60.0

func _launch() -> void:
	var angle := randf_range(-LAUNCH_ANGLE, LAUNCH_ANGLE)
	velocity = Vector2.UP.rotated(deg_to_rad(angle)) * SPEED

func respawn(spawn_position: Vector2) -> void:
	global_position = spawn_position
	_launch()

func _physics_process(delta: float) -> void:
	# Se déplace selon le vecteur initial
	var collision := move_and_collide(velocity * delta)
	
	if not collision:
		return
	
	# Rebondit si un obstacl est rencontré
	var obstacle := collision.get_collider()
	
	# Rebond différent si il s'agit du paddle
	if obstacle is Paddle:
		_bounce_on_paddle(obstacle, collision)
		return

	if obstacle is Brick:
		obstacle.hit()
	velocity = velocity.bounce(collision.get_normal())

func _bounce_on_paddle(paddle: Paddle, collision: KinematicCollision2D) -> void:
	# Convertit la position global de la collision en un point entre -1 et 1
	# 	-1 : le point le plus à gauche du paddle
	# 	 1 : le point le plus à droite du paddle
	var offset :float = (collision.get_position().x - paddle.global_position.x) / paddle.get_half_width()
	offset = clamp(offset, -1.0, 1.0)
	
	var angle :float   = deg_to_rad(offset * MAX_BOUNCE_ANGLE)
	velocity = Vector2.UP.rotated(angle) * velocity.length()

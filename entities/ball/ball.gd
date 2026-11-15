class_name Ball
extends CharacterBody2D

const SPEED :float = 200.0
const MAX_BOUNCE_ANGLE :float = 60.0
	
func _ready() -> void:
	velocity = Vector2(-0.25, -1).normalized() * SPEED

func _physics_process(delta: float) -> void:
	# Se déplace selon le vecteur initial
	var collision := move_and_collide(velocity * delta)
	
	if not collision:
		return
	
	# Rebondit si un obstacl est rencontré
	var paddle := collision.get_collider() as Paddle
	
	# Rebond différent si il s'agit du paddle
	if paddle:
		# Convertit la position global de la collision en un point entre -1 et 1
		# 	-1 : le point le plus à gauche du paddle
		# 	 1 : le point le plus à droite du paddle
		var offset := (collision.get_position().x - paddle.global_position.x) / paddle.get_half_width()
		offset = clamp(offset, -1.0, 1.0)
		
		var angle :float   = deg_to_rad(offset * MAX_BOUNCE_ANGLE)
		velocity = Vector2.UP.rotated(angle) * velocity.length()
	else:
		velocity = velocity.bounce(collision.get_normal())

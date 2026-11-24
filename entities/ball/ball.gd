class_name Ball
extends CharacterBody2D

const LAUNCH_ANGLE := 10.0

const SPEED :float = 250.0
const MAX_BOUNCE_ANGLE :float = 60.0

enum State { HELD, MOVING }
var state := State.HELD
var holder :Node2D
const HOLD_OFFSET := Vector2(0, -15)

var is_in_fire :bool = false

func is_moving() -> bool:
	return true if state == State.MOVING else false

func launch() -> void:
	if state != State.HELD:
		return

	state = State.MOVING
	var angle := randf_range(-LAUNCH_ANGLE, LAUNCH_ANGLE)
	velocity = Vector2.UP.rotated(deg_to_rad(angle)) * SPEED

func launch_in(direction: Vector2):
	state = State.MOVING
	velocity = direction.normalized() * SPEED

func hold_on(new_holder: Node2D) -> void:
	holder = new_holder
	state = State.HELD

func _physics_process(delta: float) -> void:
	if state == State.HELD:
		if holder:
			global_position = holder.global_position + HOLD_OFFSET
		return
	
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
		if is_in_fire:
			obstacle.hit(obstacle.hp)
			return
		obstacle.hit(1)
	
	velocity = velocity.bounce(collision.get_normal())

func _bounce_on_paddle(paddle: Paddle, collision: KinematicCollision2D) -> void:
	# Convertit la position global de la collision en un point entre -1 et 1
	# 	-1 : le point le plus à gauche du paddle
	# 	 1 : le point le plus à droite du paddle
	var offset :float = (collision.get_position().x - paddle.global_position.x) / paddle.get_half_width()
	offset = clamp(offset, -1.0, 1.0)
	
	var angle :float   = deg_to_rad(offset * MAX_BOUNCE_ANGLE)
	velocity = Vector2.UP.rotated(angle) * velocity.length()

func fire(duration: float) -> void:
	is_in_fire = true
	$FireTimer.start(duration)

func _on_fire_timer_timeout() -> void:
	is_in_fire = false

func add_one() -> void:
	pass
#	var copy := duplicate()	
#	get_parent().add_child(copy)

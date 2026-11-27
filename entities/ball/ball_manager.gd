class_name BallManager
extends Node2D

const BALL_SCENE := preload("res://entities/ball/ball.tscn")
const SPLIT_ANGLE := 20.0
var fire :bool = false

func spawn_on(entity: Paddle) -> void:
	var ball :Ball = BALL_SCENE.instantiate()
	ball.hold_on(entity)
	add_child.call_deferred(ball)

func launch_all() -> void:
	for ball in get_children():
		ball.launch()

func count_remaining(body: Node) -> int:
	return get_children().filter(
		func(ball: Ball): return ball != body and not ball.is_queued_for_deletion()
	).size()

func set_fire(on: bool) -> void:
	fire = on
	for ball in get_children():
		ball.set_fire(on)

func split() -> void:
	var source :Ball = get_moving_ball()
	if not source:
		return
	
	var angle := randf_range(-SPLIT_ANGLE, SPLIT_ANGLE)
	var ball :Ball = BALL_SCENE.instantiate()
	ball.global_position = source.global_position
	ball.launch_in(source.velocity.rotated(deg_to_rad(angle)))
	add_child.call_deferred(ball)

func get_moving_ball():
	for ball in get_children():
		if ball.is_moving():
			return ball
	return null

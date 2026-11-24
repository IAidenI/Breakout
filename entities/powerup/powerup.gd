@tool
class_name PowerUp
extends Area2D

signal collected(effect: PowerUpEffect)

@export var effect :PowerUpEffect:
	set(value):
		effect = value
		if is_node_ready():
			refresh()

const SPEED :float = 100.0

func _ready() -> void:
	refresh()

func _physics_process(delta: float) -> void:
	if Engine.is_editor_hint():
		return
	position.y += SPEED * delta

func refresh():
	$Sprite2D.modulate  = effect.color
	$Sprite2D/Name.text = effect.label

func _on_body_entered(body: Node2D) -> void:
	if body is Paddle:
		collected.emit(effect)
		queue_free()

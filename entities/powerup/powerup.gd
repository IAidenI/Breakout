@tool
class_name PowerUp
extends Area2D

signal collected(type: Type)

@export var type :Type:
	set(value):
		type = value
		if is_node_ready():
			refresh()

enum Type { LIFE, FIRE }
const TYPE_DATA := {
	Type.LIFE:  { "color": Color.PINK,   "label": "♥" },
	Type.FIRE:  { "color": Color.ORANGE, "label": "🔥" },
}

"""
enum Type { LARGE, SMALL, MULTI, LIFE, FIRE }
const TYPE_DATA := {
	Type.LARGE: { "color": Color.GREEN,  "label": "L" },
	Type.SMALL: { "color": Color.RED,    "label": "S" },
	Type.MULTI: { "color": Color.YELLOW, "label": "+1" },
	Type.LIFE:  { "color": Color.PINK,   "label": "♥" },
	Type.FIRE:  { "color": Color.ORANGE, "label": "🔥" },
}
"""

const SPEED :float = 100.0

func _ready() -> void:
	refresh()

func _physics_process(delta: float) -> void:
	if Engine.is_editor_hint():
		return
	position.y += SPEED * delta

func refresh():
	var data :Dictionary = TYPE_DATA[type]
	$Sprite2D.modulate  = data["color"]
	$Sprite2D/Name.text = data["label"]

func _on_body_entered(body: Node2D) -> void:
	if body is Paddle:
		collected.emit(type)
		queue_free()

@tool
class_name Brick
extends StaticBody2D

enum Type { FLAT, WIDE, SQUARE }
@export var type :Type:
	set(value):
		type = value
		if is_node_ready():
			apply_type()

const TYPE_DATA := {
	Type.FLAT:   { "region": Rect2(  0, 7, 96,  9), "states": 3 },
	Type.WIDE:   { "region": Rect2(112, 0, 96, 16), "states": 3 },
	Type.SQUARE: { "region": Rect2(224, 0, 32, 16), "states": 2 },
}

var max_hp :int = 0
var hp     :int = 0

func _ready() -> void:
	apply_type()

func apply_type() -> void:
	var data: Dictionary = TYPE_DATA[type]
	
	max_hp = data["states"]
	hp     = max_hp
	
	$Sprite2D.region_rect = data["region"]
	$Sprite2D.hframes     = data["states"]
	$Sprite2D.frame       = 0
	
	$Hitbox.shape.size.x = data["region"].size.x / data["states"]
	$Hitbox.shape.size.y = data["region"].size.y

static func get_size_for(t: Type) -> Vector2:
	var data: Dictionary = TYPE_DATA[t]
	return Vector2(data["region"].size.x / data["states"], data["region"].size.y)

func hit() -> void:
	hp -= 1
	if hp <= 0:
		queue_free()
	else:
		$Sprite2D.frame = max_hp - hp

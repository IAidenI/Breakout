class_name LevelBuilder
extends Node2D

signal level_cleared()

@export var brick_scene :PackedScene
var remaining :int = 0

## Parcourt le layout et construit le niveau
func build(data: LevelData) -> Vector2:
	var cursor     :Vector2 = Vector2.ZERO
	var cell_size  :Vector2 = data.get_cell_size()
	var level_size :Vector2 = Vector2.ZERO
	
	for row in data.layout:
		for cell in row:
			var type :int = data.char_to_brick_type(cell)

			# Si il s'agit d'une brique
			if type != -1:
				spawn_brick(type, cursor)
				cursor.x += Brick.get_size_for(type).x
			else: # Si il s'agit d'un bloc vide
				cursor.x += cell_size.x
		level_size.x = max(level_size.x, cursor.x)
		cursor.x = 0
		cursor.y += cell_size.y
	level_size.y = cursor.y
	return level_size

## Crée une brique d'un type donné, son coin haut-gauche à la position donnée
func spawn_brick(type: Brick.Type, top_left: Vector2) -> void:
	var brick :Brick = brick_scene.instantiate()
	brick.type = type
	brick.position = top_left + Brick.get_size_for(type) / 2
	add_child(brick)
	
	brick.destroyed.connect(_on_brick_destroyed)
	remaining += 1

func _on_brick_destroyed() -> void:
	remaining -= 1
	if remaining <= 0:
		level_cleared.emit()

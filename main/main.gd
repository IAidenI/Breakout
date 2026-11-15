class_name Main
extends Node2D

@export var level: LevelData
@export var brick_scene: PackedScene

func _ready() -> void:
	var current_position :Vector2 = $Bricks.position
	var brick_size :Vector2 = Brick.get_size_for(Brick.Type.FLAT)
	
	# Crée le niveau
	for line in level.layout:
		for c in line:
			# Place la brique correspondante sur la scène
			if c != level.VOID_ID:
				var brick = brick_scene.instantiate()
				brick.position = current_position
				
				# Change les propriétés en fonction du type de brique
				if c == level.BRICK_ID:
					if level.brick_size == level.Type.NORMAL:
						brick.type = Brick.Type.FLAT
						brick_size = Brick.get_size_for(Brick.Type.FLAT)
					elif level.brick_size == level.Type.LARGE:
						brick.type = Brick.Type.WIDE
						brick_size = Brick.get_size_for(Brick.Type.WIDE)
				elif c == level.SQUARE_ID and level.brick_size == level.Type.LARGE:
					brick.type = Brick.Type.SQUARE
					brick_size = Brick.get_size_for(Brick.Type.SQUARE)
				
				# Place la brick sur la scène
				brick.position = current_position + brick_size / 2
				$Bricks.add_child(brick)
			
			# Change de position
			current_position.x += brick_size.x
		current_position.x = $Bricks.position.x
		current_position.y += brick_size.y

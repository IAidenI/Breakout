@tool
class_name LevelData
extends Resource

enum Type { NORMAL, LARGE }
@export var layout :Array[String]
@export var type   :Type

const BRICK_ID  := "X"
const SQUARE_ID := "S"
const VOID_ID   := "."

const VALIDATE_CHAR :Array[String] = [ BRICK_ID, SQUARE_ID, VOID_ID ]

func validate_level() -> bool:
	for row in layout:
		for cell in row:
			# Vérifie si il ne s'agit pas d'un caractère invalide
			if cell not in LevelData.VALIDATE_CHAR:
				return false
			
			# Vérifie si le bon type de brique à été utilisé
			if type == LevelData.Type.NORMAL:
				if cell == LevelData.SQUARE_ID:
					return false
	return true

## Traduit un caractère en type de brique selon la taille du niveau
## Renvoie -1 pour le vide
func char_to_brick_type(cell: String) -> int:
	if cell == LevelData.BRICK_ID:
		return Brick.Type.FLAT if type == LevelData.Type.NORMAL else Brick.Type.WIDE
	elif cell == LevelData.SQUARE_ID:
		return Brick.Type.SQUARE
	else: # c == LevelData.VOID_ID
		return -1

## Taille d'une case vide selon la taille du niveau
func get_cell_size() -> Vector2:
	if type == LevelData.Type.NORMAL:
		return Brick.get_size_for(Brick.Type.FLAT)
	else: # type == LevelData.Type.LARGE:
		return Brick.get_size_for(Brick.Type.SQUARE)

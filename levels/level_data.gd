class_name LevelData
extends Resource

enum Type { NORMAL, LARGE }
@export var layout     :Array[String]
@export var brick_size :Type

const BRICK_ID  := "X"
const SQUARE_ID := "S"
const VOID_ID   := "."

class_name Hud
extends Control

@export var heart_full  :Texture2D
@export var heart_empty :Texture2D

const HUD_SCALE :int = 3

func _ready() -> void:
	for i in PlayerState.MAX_LIVES:
		var heart := TextureRect.new()
		heart.expand_mode = TextureRect.EXPAND_IGNORE_SIZE
		heart.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT_CENTERED
		heart.custom_minimum_size = heart_full.get_size() * HUD_SCALE
		$MarginContainer/Hearts.add_child(heart)
	
	PlayerState.lives_changed.connect(_on_lives_changed)
	_on_lives_changed(PlayerState.lives)

func _on_lives_changed(lives: int) -> void:
	var hearts := $MarginContainer/Hearts.get_children()
	
	for i in hearts.size():
		hearts[i].texture = heart_full if i < lives else heart_empty

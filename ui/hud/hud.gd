class_name Hud
extends Control

@export var heart_full  :Texture2D
@export var heart_empty :Texture2D

const HUD_SCALE :int = 3
@onready var bars: Dictionary[String, TextureProgressBar] = {
	"FIRE": $ActiveEffects/Effects/FireProgressBar,
	"LARGE": $ActiveEffects/Effects/LargeProgressBar,
	"SMALL": $ActiveEffects/Effects/SmallProgressBar,
}
@onready var labels: Dictionary[String, Label] = {
	"FIRE": $ActiveEffects/Effects/FireLabel,
	"LARGE": $ActiveEffects/Effects/LargeLabel,
	"SMALL": $ActiveEffects/Effects/SmallLabel,
}
var timers :Dictionary[String, Timer] = {}

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

func _process(_delta: float) -> void:
	for effect_name in timers:
		bars[effect_name].value = timers[effect_name].time_left

func on_effect_started(effect: PowerUpEffect, timer: Timer) -> void:
	timers[effect.display_name] = timer
	bars[effect.display_name].max_value = effect.duration
	set_row_visible(effect.display_name, true)

func on_effect_ended(effect: PowerUpEffect) -> void:
	timers.erase(effect.display_name)
	bars[effect.display_name].value = 0
	set_row_visible(effect.display_name, false)
	
func set_row_visible(effect_name: String, on: bool) -> void:
	labels[effect_name].visible = on
	bars[effect_name].visible = on

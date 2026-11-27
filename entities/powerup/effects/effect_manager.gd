class_name EffectManager
extends Node

signal effect_started(effect: PowerUpEffect, timer: Timer)
signal effect_ended(effect: PowerUpEffect)

var _game   :Game

class ActiveEffect:
	var effect :PowerUpEffect
	var timer  :Timer

var active :Dictionary[PowerUpEffect.Slot, ActiveEffect] = {}

func setup(game: Game) -> void:
	_game = game

func activate(effect: PowerUpEffect) -> void:
	if effect.duration <= 0.0:
		effect.apply(_game)
		return
	
	if active.has(effect.slot):
		var current :ActiveEffect = active[effect.slot]
		if current.effect != effect:
			current.effect.remove(_game)
			effect_ended.emit(current.effect)
			current.effect = effect
		effect.apply(_game)
		current.timer.start(effect.duration)
		effect_started.emit(effect, current.timer)
		return
	
	var timer := Timer.new()
	timer.one_shot = true
	add_child(timer)
	timer.timeout.connect(_on_timeout.bind(effect.slot))
	
	var entry := ActiveEffect.new()
	entry.effect = effect
	entry.timer = timer
	active[effect.slot] = entry
	
	effect.apply(_game)
	timer.start(effect.duration)
	effect_started.emit(effect, timer)

func _on_timeout(slot: PowerUpEffect.Slot) -> void:
	var entry: ActiveEffect = active[slot]
	entry.effect.remove(_game)
	effect_ended.emit(entry.effect)
	entry.timer.queue_free()
	active.erase(slot)

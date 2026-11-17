@tool
class_name LevelCard
extends PanelContainer

@export var title       :String = "Title":
	set(value):
		title = value
		if is_node_ready():
			update()

@export var button_text :String = "Select":
	set(value):
		button_text = value
		if is_node_ready():
			update()

@export var level :LevelData:
	set(value):
		level = value
		if is_node_ready():
			update()

func _ready() -> void:
	update()

func update() -> void:
	$VBoxContainer/Title.text = title
	$VBoxContainer/SelectButton.text = button_text
	$VBoxContainer/SubViewportContainer/SubViewport/LevelPreview.level = level

func _on_select_button_pressed() -> void:
	PlayerState.reset()
	SceneManager.goto("game", { "level": level })

extends Node


func _ready() -> void:
	GameEvents.died.connect(on_died)


func on_died():
	get_tree().quit()

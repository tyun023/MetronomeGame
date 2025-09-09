extends Node


signal died


func on_death():
	died.emit()

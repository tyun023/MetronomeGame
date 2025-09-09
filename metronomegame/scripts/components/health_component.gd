extends Node
class_name HealthComponent

@export var max_health: int = 10
var health: int


func _ready() -> void:
	health = max_health


func damage(damage):
	health -= damage
	if health <= 0:
		GameEvents.on_death()
	print(health)

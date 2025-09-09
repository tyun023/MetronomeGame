extends Area2D
class_name HurtboxComponent

@export var healt_component: HealthComponent



func _ready() -> void:
	area_entered.connect(on_area_entered)


func on_area_entered(other_area: HitboxComponent):
	if other_area is HitboxComponent:
		healt_component.damage(2)

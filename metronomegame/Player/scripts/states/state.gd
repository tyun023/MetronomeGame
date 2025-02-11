class_name State extends Node


##Stores a reference to the player that this State belongs to
static var player: Player

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# When player enters state
func Enter() -> void:
	pass
	
# When player enters state
func Exit() -> void:
	pass

# When _process update in this state
func Process(_delta : float) -> State:
	return null
# When _physics_process in this state
func Physics(_delta : float) -> State:
	return null

# When input event in this state
func HandleInput(_event : InputEvent) -> State:
	return null

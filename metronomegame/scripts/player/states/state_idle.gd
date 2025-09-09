class_name State_Idle extends State

@onready var walk : State = $"../Walk"
@onready var dash : State_Dash = $"../Dash"

# When player enters state
func Enter() -> void:
	#player.UpdateAnimation("idle")
	print("idle")
	pass
	
# When player enters state
func Exit() -> void:
	pass

# When _process update in this state
func Process(_delta : float) -> State:
	if player.direction != Vector2.ZERO:
		return walk
	player.velocity = Vector2.ZERO
	return null
# When _physics_process in this state
func Physics(_delta : float) -> State:
	return null

# When input event in this state
func HandleInput(_event : InputEvent) -> State:
	if (_event.is_action_pressed("dash") && !dash.on_cooldown):
		return dash
	return null

class_name State_Dash extends State

@onready var walk : State = $"../Walk"
@onready var idle : State = $"../Idle"

var note : QuarterNote

var internal_dash_timer : float = 0.0

var dash_direction : Vector2 = Vector2.ZERO
var initial_position : Vector2 = Vector2.ZERO

@export_group("Dash Attributes")
@export var initial_speed : float = 2000
@export var dash_length : int = 100

var dash_duration : float = 0.2

var on_cooldown : bool = false

func _ready() -> void:
	note = QuarterNote.new()
	note._set_metronome($"../../Metronome")
	pass

# When player enters state
func Enter() -> void:
	#player.UpdateAnimation("idle")
	#needed for dashing
	dash_direction = Vector2.RIGHT.rotated(player.rotation)
	initial_position = player.position
	player.velocity = dash_direction * initial_speed
	
	print("Dash")
	
	#keep track of how long ability goes on cooldown for
	on_cooldown = true
	internal_dash_timer = 0.0
	dash_duration = note.get_beat_duration()
	print(dash_duration)
	get_tree().create_timer(dash_duration).timeout.connect(func():
		on_cooldown = false
		print("cooldown over")
		)
	pass
	
# When player exits state
func Exit() -> void:
	pass

# When _process update in this state
func Process(_delta : float) -> State:

	return null

# When _physics_process in this state
func Physics(_delta : float) -> State:
	internal_dash_timer += _delta
	#return to neutral state if dash has passed just in case. Hopefully just a redundancy
	if (dash_duration < internal_dash_timer):
		return _exit_state()
		
	player.move_and_slide()
	if (initial_position.distance_to(player.position) >= dash_length):
		return _exit_state()
	
	return null

# When input event in this state
func HandleInput(_event : InputEvent) -> State:
	return null
	
func _exit_state() -> State:
	if (player.direction.is_zero_approx()):
		return idle
	else:
		return walk

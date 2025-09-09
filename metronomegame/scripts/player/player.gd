class_name Player extends CharacterBody2D

signal hit

var cardinal_direction : Vector2 = Vector2.DOWN
var direction : Vector2 = Vector2.ZERO

#@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D
#@onready var sprite: AnimatedSprite2D = $PlayerSprite

#@export var speed = 200 # How fast the player will move (pixels/sec).

var invincible : bool = false

@onready var state_machine : PlayerStateMachine = $StateMachine

#might use
enum CHAR_FACING {LEFT, RIGHT, UP, DOWN}
var facing = CHAR_FACING.RIGHT

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	state_machine.Initialize(self)
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	_movement(delta);
	pass

func _movement(delta: float) -> void:
	direction = Input.get_vector("move_left", "move_right", "move_up", "move_down").normalized()
	_turn_char(direction)
	
	

func _turn_char(dir: Vector2) -> void:
	if (!dir.is_zero_approx()): 
		rotation = dir.angle()
	

func _on_body_entered(body: Node2D) -> void:
	#if something that deals damage
	hide() # Player disappears after being hit.
	hit.emit()
	# Must be deferred as we can't change physics properties on a physics callback.
	$CollisionShape2D.set_deferred("disabled", true)
	pass # Replace with function body.

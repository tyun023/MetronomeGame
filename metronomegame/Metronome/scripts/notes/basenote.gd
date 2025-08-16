class_name BaseNote extends Node

var duration : float
var notes_per_measure : float
var notes_per_beat : float
var attributes : SongAttributes

var _beat_value : int = 0

var metronome : Metronome
var time_since_beat : float = 0

var _internal_timer : float = 0
var _curr_note : int = 0

var time_since_measure : float = 0

func _init() -> void:
	pass

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.
	
func _set_metronome(meter : Metronome) -> void:
	metronome = meter
	metronome.beat_occured.connect(_on_beat_occurred)
	attributes = metronome.getAttributes()
	
	print("why")
	
	if (attributes != null):
		#calculates basic info from time signature
		notes_per_beat =  _beat_value / attributes.time_signature[1]
		print(notes_per_beat)
		notes_per_measure = attributes.time_signature[0] * notes_per_beat
		
		#calculates the seconds per note
		print(attributes.bpm)
		duration = 60 / (notes_per_beat * attributes.bpm)

func _on_beat_occurred() -> void:
	time_since_beat = 0
	#syncing the internal timer to make sure it doesn't get out of sync every so often
	#doesn't quite work for one and half beat, so need to figure that out
	#if (_curr_note >= notes_per_beat):
	#	_internal_timer = 0
	#	_curr_note = 0
	if (abs(_internal_timer - time_since_beat) < duration / 32):
		_internal_timer = 0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	time_since_beat += delta
	_internal_timer += delta
	if (_internal_timer >= duration):
		_internal_timer = 0
		_curr_note += 1
	pass
	
# returns duration of the beat
func get_beat_duration() -> float:
	return duration

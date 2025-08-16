class_name Metronome extends Node

var attributes : SongAttributes

var _bps : float #= 60.0 / bpm
var _hbps : float #= .5 * _bps
#twelfth bps makes it easier to divide a beat into usable parts. 
# i.e. Qtr notes: 12, sixtheenth: 6, 32nd: 3, triplets, 4 
var _twelfth_bps : float #= twelfth beats per second. 

var _time_since_last_beat : float = 0

var current_beat : int = 0

signal beat_occured


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	attributes = load("res://Metronome/SongAttributes/song_attributes_default.tres")
	var bpm : int = attributes.bpm
	_bps = 60.0 / bpm
	current_beat = 0
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func _physics_process(delta: float) -> void:
	#counts how many halfbeats/beats have passed, and sends out signals for 
	_time_since_last_beat += delta
	
	var spb = 1 / _bps
		
	if ( _time_since_last_beat >= 1 / spb):
		_time_since_last_beat -= 1 / spb
		current_beat += 1
		emit_signal("beat_occured")
		

#emit different beat signals for each note denomination
	
func getAttributes() -> SongAttributes:
	if (attributes == null):
		attributes = load("res://Metronome/SongAttributes/song_attributes_default.tres")
	return attributes
	
func setAttributes(att : SongAttributes) -> bool:
	attributes = att
	if (attributes == null):
		return false
	return true
	
func setAttributesName(att_name : String) -> bool:
	var att = load(str("res://Metronome/SongAttributes/", att_name, ".tres"))
	return setAttributes(att)

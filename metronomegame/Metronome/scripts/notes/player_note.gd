class_name PlayerNote extends Node

var note : BaseNote

#enum Notes {WHOLE_NOTE,HALF_NOTE,QUARTER_NOTE, EIGHTH_NOTE, SIXTEENTH_NOTE}

#var playable_on : Notes = Notes.EIGHTH_NOTE
var playable_on : BaseNote
var offset : float


#value from 0 to 10 determining the ranges at which something is considered a hit or not
@export var timing_difficulty : float = 6.5

enum Note_Score {PERFECT, GOOD, BAD, MISS}

#milliseconds 
@export var perfect_range : float = (80 - 6 * timing_difficulty) * .001
@export var good_range : float = (140 - 8 * timing_difficulty) * .001
@export var bad_range : float = (200 - 10 * timing_difficulty) * .001

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
#TODO, calculate note rating depending on how close to how off the input is from the beat/playable beat
func give_note_rating() -> Note_Score:
	var error_dist : float = _error_from_valid_note()
	if (error_dist < perfect_range):
		print("perfect")
		return Note_Score.PERFECT
	if (error_dist < good_range):
		print("good")
		return Note_Score.GOOD
	if (error_dist < bad_range):
		print("bad")
		return Note_Score.BAD
	print("miss")
	return Note_Score.MISS

# TODO, if the bpm is too high, the ranges might go outside the beat timings
# at least make it so that they have to be within the range of the beat
func _recalculate_ranges() -> void:
	pass
	
# TODO, get the absolute distance from a playable note. Only positive values, no negative
func _error_from_valid_note() -> float:
	var bottom_time_sig: int = note.attributes.time_signature[1]
	#var tsb : float = #note.time_since_beat
	var tsb: float = playable_on._internal_timer
	
	#var beat_length = note.get_beat_duration()
	
	var note_length : float = playable_on.get_beat_duration()
	var error_diffs : Array[float] = [
		tsb,
		note_length - tsb
	]
	#Case for when playable_on <= note
	
	
	'''
	#calculates the difference between notes and the playable timings
	var npb : float = playable_on.notes_per_beat #how many notes per beat
	var note_length : float = playable_on.get_beat_duration()
	for i in range(0, npb + 1):
		error_diffs.append(abs((note_length * i) - tsb))
		
	#TODO case for when playable_on > note
	'''
	print(error_diffs.min())
	
	return error_diffs.min()

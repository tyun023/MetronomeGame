class_name SongAttributes extends Resource

@export var bpm : float = 120
@export var time_signature : Array[int] = [4,4]


#sets the time signiture
#top : int, sets how many beats in a measure
#bottom : int, sets which note gets the beat
func set_time_signature(top : int, bottom: int) -> bool:
	if (top == 0 || bottom == 0):
		return false
	time_signature[0] = top
	time_signature[1] = bottom
	return true

extends Resource
class_name Exit

var room_one = null
var room_one_is_locked := false

var room_two = null
var room_two_is_locked := false

func get_other_room(room):
	if room == room_one:
		return room_one
	elif room == room_two:
		return room_two
	else:
		printerr("The room your tried to find is not connected to this exit!!")
		return null

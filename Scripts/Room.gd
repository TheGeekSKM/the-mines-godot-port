extends PanelContainer
class_name GameRoom 

export (String) var room_name = "Room Name"
export (String) var rooom_description = "This is the description of the room."

var exits: Dictionary = {}

func connect_exit(direction: String, room: GameRoom):
	match direction:
		"north":
			exits[direction] = room
			room.exits["south"] = self
		"south":
			exits[direction] = room
			room.exits["north"] = self
		"east":
			exits[direction] = room
			room.exits["west"] = self
		"west":
			exits[direction] = room
			room.exits["east"] = self
		_:
			printerr("Tried to connect to invalid direction: %s", direction)

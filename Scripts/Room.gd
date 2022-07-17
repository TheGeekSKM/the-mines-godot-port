tool
extends PanelContainer
class_name GameRoom 

export (String) var room_name = "Room Name" setget set_room_name
export (String, MULTILINE) var rooom_description = "This is the description of the room." setget set_room_description

func set_room_name(new_name: String):
	$MarginContainer/Rows/RoomName.text = new_name
	room_name = new_name

func set_room_description(new_description: String):
	$MarginContainer/Rows/RoomDescription.text = new_description
	rooom_description = new_description

var exits: Dictionary = {}

func connect_exit(direction: String, room: GameRoom):
	
	var exit = Exit.new()
	exit.room_one = self
	exit.room_two = room
	exits[direction] = exit
	
	match direction:
		"north":
			room.exits["south"] = exit
		"south":
			room.exits["north"] = exit
		"east":
			room.exits["west"] = exit
		"west":
			room.exits["east"] = exit
		_:
			printerr("Tried to connect to invalid direction: %s", direction)

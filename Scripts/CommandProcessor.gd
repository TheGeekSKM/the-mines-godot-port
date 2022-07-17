extends Node


var current_room = null

func initialize(starting_room) -> String:
	return change_room(starting_room)


func process_command(input: String):
	var words = input.split(" ", false, 0)
	if words.size() == 0:
		return "Error, no words were parsed"
	
	var first_word = words[0].to_lower()
	var second_word = ""
	
	if words.size() > 1:
		second_word = words[1].to_lower()
	
	match first_word:
		"go":
			return go(second_word)
		"help":
			return help()
		_:
			return "Unrecognized command...please try again..."


func go(second_word: String): 
	if second_word == "":
		return "You need to specify a direction/location with the \"go\" command. EX: \"go east\" "
	
	if 	current_room.exits.keys().has(second_word):
		var change_response = change_room(current_room.exits[second_word])
		return PoolStringArray(["You head to %s" % second_word, change_response]).join("\n")
	else:
		return "There is no doorway to the %s" % second_word

func help():
	return "You can use these commands: go [location], help"

func change_room(new_room: GameRoom) -> String:
	current_room = new_room
	var exit_string = PoolStringArray(new_room.exits.keys()).join(" ")
	
	var strings = PoolStringArray([
		"You are now in: " + new_room.room_name, 
		"It is " + new_room.rooom_description,
		"Exits: " + exit_string]).join("\n")
	return strings


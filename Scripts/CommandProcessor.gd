extends Node

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
	
	return "You head to the %s" % second_word

func help():
	return "You can use these commands: go [location], help"

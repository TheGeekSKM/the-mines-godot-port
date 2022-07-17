extends Control

const InputResponse = preload("res://Scenes/InputResponse.tscn")
const Response = preload("res://Scenes/Response.tscn")

export (int) var max_lines_remembered := 30 
export (String) var intro_text := "You awake in a dark cave..."

var max_scroll_length := 0

onready var history_rows = $Background/MarginContainer/Rows/GameInfo/Scroll/HistoryRows
onready var scroll = $Background/MarginContainer/Rows/GameInfo/Scroll
onready var scroll_bar = scroll.get_v_scrollbar()
onready var command_processor = $CommandProcessor
onready var room_manager = $RoomManager

func _ready() -> void:
	scroll_bar.connect("changed", self, "handle_scroll_bar_changed")
	max_scroll_length = scroll_bar.max_value
	
	create_response("You awake in a small cavernous area, surrounded by stalactites and small stones. The only sounds you can hear are the drips of water periodically reminding you of the pitfalls that await you...You need to get out before it's too late... [HINT: Type \"help\" to see all the available commands]")
	
	var starting_room_response = command_processor.initialize(room_manager.get_child(0))
	create_response(starting_room_response)
	

func handle_scroll_bar_changed():
	
	if max_scroll_length != scroll_bar.max_value:
		max_scroll_length = scroll_bar.max_value
		scroll.scroll_vertical = max_scroll_length



func _on_Input_text_entered(new_text: String) -> void:
	if new_text.empty():
		return
	
	var input_response = InputResponse.instance()
	var response = command_processor.process_command(new_text)
	input_response.set_text(new_text, response)
	
	add_response_to_game(input_response)

#responds to the room_changing signal
func create_response(response_text: String):
	var response = Response.instance()
	response.text = response_text
	add_response_to_game(response)

#Prints text out to the screen
func add_response_to_game(response: Control):
	history_rows.add_child(response)
	delete_history_beyond_limit()	


func delete_history_beyond_limit():
	if history_rows.get_child_count() > max_lines_remembered:
		var rows_to_forget = history_rows.get_child_count() - max_lines_remembered
		for i in range(rows_to_forget):
			history_rows.get_child(i).queue_free()

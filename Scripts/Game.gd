extends Control

const InputResponse = preload("res://Scenes/InputResponse.tscn")

export (int) var max_lines_remembered := 30 

var max_scroll_length := 0

onready var history_rows = $Background/MarginContainer/Rows/GameInfo/Scroll/HistoryRows
onready var scroll = $Background/MarginContainer/Rows/GameInfo/Scroll
onready var scroll_bar = scroll.get_v_scrollbar()

func _ready() -> void:
	scroll_bar.connect("changed", self, "handle_scroll_bar_changed")
	max_scroll_length = scroll_bar.max_value


func handle_scroll_bar_changed():
	
	if max_scroll_length != scroll_bar.max_value:
		max_scroll_length = scroll_bar.max_value
		scroll.scroll_vertical = max_scroll_length



func _on_Input_text_entered(new_text: String) -> void:
	if new_text.empty():
		return
	
	var input_response = InputResponse.instance()
	input_response.set_text(new_text, "This is where a response would go...")
	history_rows.add_child(input_response)
	
	if history_rows.get_child_count() > max_lines_remembered:
		var rows_to_forget = history_rows.get_child_count() - max_lines_remembered
		
		for i in range(rows_to_forget):
			history_rows.get_child(i).queue_free()
	

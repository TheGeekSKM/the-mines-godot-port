extends LineEdit



func _ready() -> void:
	grab_focus()







# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	pass


func _on_Input_text_entered(new_text: String) -> void:
	clear()

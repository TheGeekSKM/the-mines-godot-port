extends Node

func _ready() -> void:
	$CavernRoom.connect_exit("east", $LibraryRoom)



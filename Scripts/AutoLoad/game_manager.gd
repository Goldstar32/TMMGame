extends Node

var pausable = true
var cam : Camera2D

func _input(event : InputEvent):
	if event.is_action_released("pause") and pausable:
		if get_tree().paused:
			unpause()
		else:
			pause()

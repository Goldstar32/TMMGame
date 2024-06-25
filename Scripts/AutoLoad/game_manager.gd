extends Node

var pausable = true
var cam : Camera2D

func _input(event : InputEvent):
	if event.is_action_released("pause") and pausable:
		if get_tree().paused:
			unpause()
		else:
			pause()
		
func pause():
	get_tree().paused = true
	
	var pause_menu = preload("res://Scenes/Menus/pause_menu.tscn")
	var pause_menu_instance : Control = pause_menu.instantiate()
	if cam:
		pause_menu_instance.scale = Vector2(cam.zoom[0] ** -1, cam.zoom[1] ** -1)
		cam.add_child(pause_menu_instance)
	else:
		get_tree().root.add_child(pause_menu_instance)
func unpause():
	get_tree().pasued = false
	
	
func set_cam(camera : Camera2D):
	cam = camera
func set_pausible(paus : bool):
	pausable = paus

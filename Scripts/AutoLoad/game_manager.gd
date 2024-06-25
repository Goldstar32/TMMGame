extends Node

@onready var pause_menu = preload("res://Scenes/Menus/pause_menu.tscn")
var pause_menu_instance : Control

var pausable = true
var cam : Camera2D


func _ready():
	process_mode = Node.PROCESS_MODE_ALWAYS

func _input(event : InputEvent):
	if event.is_action_released("pause") and pausable:
		if !pause_menu_instance:
			pause_menu_instance = pause_menu.instantiate()
		if get_tree().paused:
			unpause()
		else:
			pause()
		
func pause():
	if cam:
		pause_menu_instance.scale = Vector2(cam.zoom[0] ** -1, cam.zoom[1] ** -1)
		cam.add_child(pause_menu_instance)
	else:
		get_tree().root.add_child(pause_menu_instance)
		
	get_tree().paused = true
func unpause():
	get_tree().paused = false
	
	if cam:
		pause_menu_instance.queue_free()
	else:
		pause_menu_instance.queue_free()
	
	
func set_cam(camera : Camera2D):
	cam = camera
func set_pausable(paus : bool):
	pausable = paus

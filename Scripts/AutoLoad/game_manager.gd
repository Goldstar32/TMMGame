extends Node

@onready var pause_menu = preload("res://Scenes/Menus/pause_menu.tscn")
var pause_menu_instance : Control

var pausable = true
var cam : Camera2D
var screen_size
var menu_tablet : Control
var tween : Tween
var anabled = true

func _ready():
	process_mode = Node.PROCESS_MODE_ALWAYS

func _input(event : InputEvent):
	if event.is_action_released("pause") and pausable:
		if anabled:
			anabled = false
			
			if !pause_menu_instance:
				pause_menu_instance = pause_menu.instantiate()
				menu_tablet = pause_menu_instance.find_child("MenuPanel")
			if get_tree().paused:
				unpause()
			else:
				pause()
			
func pause():
	get_tree().paused = true
	update_screen_size()
	
	if cam:
		pause_menu_instance.scale = Vector2(cam.zoom[0] ** -1, cam.zoom[1] ** -1)
		cam.add_child(pause_menu_instance)
		cam_animate("in")
	else:
		get_tree().root.add_child(pause_menu_instance)
		screen_animate("in")

func unpause():
	update_screen_size()
	
	if cam:
		cam_animate("out")
		await get_tree().create_timer(0.5).timeout
		pause_menu_instance.queue_free()
	else:
		screen_animate("out")
		await get_tree().create_timer(0.5).timeout
		pause_menu_instance.queue_free()
	pause_menu_instance = null
	get_tree().paused = false
	
	
func set_cam(camera : Camera2D):
	cam = camera
func set_pausable(paus : bool):
	pausable = paus
	
# Makes a tween based on the screen size
func screen_animate(direction):
	var x_pos = screen_size[0]/2 - menu_tablet.size[0]/2
	var y_pos = screen_size[1]/2 - menu_tablet.size[1]/2
	
	if tween:
		tween.kill()
	tween = pause_menu_instance.create_tween()
	if direction == "in":
		menu_tablet.set_position(Vector2(x_pos, screen_size[1]))
		tween.tween_property(menu_tablet, "position", Vector2(x_pos, y_pos), 0.5)
	if direction == "out":
		tween.tween_property(menu_tablet, "position", Vector2(x_pos, screen_size[1]), 0.5)
	await tween.finished
	anabled = true
func cam_animate(direction):
	var x_pos = -menu_tablet.size[0]/2
	var y_pos = -menu_tablet.size[1]/2
	
	if tween:
		tween.kill()
	tween = pause_menu_instance.create_tween()
	if direction == "in":
		menu_tablet.set_position(Vector2(x_pos, -y_pos))
		tween.tween_property(menu_tablet, "position", Vector2(x_pos, y_pos), 0.5)
	if direction == "out":
		tween.tween_property(menu_tablet, "position", Vector2(x_pos, -y_pos), 0.5)
	await tween.finished
	anabled = true
# Available function everywhere to get current screen size
func update_screen_size():
	screen_size = get_viewport().get_visible_rect().size
	return screen_size

extends Control
@onready var options_menu = $"."
@onready var click_sound = preload("res://Assets/SFX/spacebar-click-keyboard-199448.mp3")
@onready var menu_panel = $MenuPanel
@onready var sfx_bus = AudioServer.get_bus_index("SFX")
var screenSize 

# Called when the node enters the scene tree for the first time.
func _ready():
	var sfx_slider = $MenuPanel/MarginContainer/VBoxContainer/GridContainer2/SFXSlider
	sfx_slider.value = db_to_linear(AudioServer.get_bus_volume_db(sfx_bus))

	screenSize = get_viewport().get_visible_rect().size
	animateMenu("up")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	screenSize = get_viewport().get_visible_rect().size

func _on_button_button_up():
	$SFX.stream = click_sound
	$SFX.play()
	
	animateMenu("down")
	await get_tree().create_timer(0.5).timeout
	get_tree().root.remove_child(options_menu)

#gör en tween som är baserad på skärmstorleken
func animateMenu(direction):
	var posX = screenSize[0]/2 - menu_panel.size[0]/2
	var posY = screenSize[1]/2 - menu_panel.size[1]/2
	
	var tween = get_tree().create_tween()
	if direction == "up":
		menu_panel.set_position(Vector2(posX, screenSize[1]))
		tween.tween_property(menu_panel, "position", Vector2(posX, posY), 0.5)
	if direction == "down":
		tween.tween_property(menu_panel, "position", Vector2(posX, screenSize[1]), 0.5)

func _on_option_button_item_selected(index):
	$SFX.stream = click_sound
	$SFX.play()
	
	#Ändrar skärmläge i spelet
	match index:
		0:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_MAXIMIZED)
		1:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_EXCLUSIVE_FULLSCREEN)
		2:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)



func _on_SFXSlider_value_changed(value):
	AudioServer.set_bus_volume_db(sfx_bus, linear_to_db(value))
	

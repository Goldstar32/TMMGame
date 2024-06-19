extends Control
@onready var options_menu = $"."
@onready var click_sound = preload("res://Assets/SFX/spacebar-click-keyboard-199448.mp3")


# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_button_button_up():
	$SFX.stream = click_sound
	$SFX.play()
	await get_tree().create_timer(0.3).timeout
	get_tree().root.remove_child(options_menu)


func _on_option_button_item_selected(index):
	#Ändrar skärmläge i spelet
	match index:
		0:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_MAXIMIZED)
		1:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_EXCLUSIVE_FULLSCREEN)
		2:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)

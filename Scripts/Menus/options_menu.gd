extends Control
@onready var options_menu = $"."
@onready var click_sound = preload("res://Assets/SFX/spacebar-click-keyboard-199448.mp3")
@onready var menu_panel = $MenuPanel
var screenSize 

# Called when the node enters the scene tree for the first time.
func _ready():
	screenSize = get_viewport().get_visible_rect().size
	animateMenu("up")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	screenSize = get_viewport().get_visible_rect().size


func _on_button_button_up():
	$AudioStreamPlayer2D.stream = click_sound
	$AudioStreamPlayer2D.play()
	
	animateMenu("down")
	await get_tree().create_timer(0.5).timeout
	get_tree().root.remove_child(options_menu)


func animateMenu(direction):
	var posX = screenSize[0]/2 - menu_panel.size[0]/2
	var posY = screenSize[1]/2 - menu_panel.size[1]/2
	
	var tween = get_tree().create_tween()
	if direction == "up":
		menu_panel.set_position(Vector2(posX, screenSize[1]))
		tween.tween_property(menu_panel, "position", Vector2(posX, posY), 0.5)
	if direction == "down":
		tween.tween_property(menu_panel, "position", Vector2(posX, screenSize[1]), 0.5)

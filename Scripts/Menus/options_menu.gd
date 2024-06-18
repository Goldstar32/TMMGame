extends Control
@onready var options_menu = $"."


# Called when the node enters the scene tree for the first time.
func _ready():
	#spela padda up animationen
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_button_button_up():
	#spela animationen i en halv sekund och ta bort options från scenen
	$ClickSFX.play()
	await get_tree().create_timer(0.3).timeout
	get_tree().root.remove_child(options_menu)

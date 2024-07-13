extends StaticBody2D

@onready var actionable = $Actionable
var player_in_area
var dialogue_enabled = true

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if player_in_area:
		if Input.is_action_just_pressed("action") and dialogue_enabled:
			run_dialogue()
	pass

func run_dialogue():
	Dialogic.start("testperson_greeting")
	dialogue_enabled = false
	Dialogic.timeline_ended.connect(dialogue_ended)
	

func dialogue_ended():
	dialogue_enabled = true
	
func _on_actionable_area_entered(area):
	player_in_area = true


func _on_actionable_area_exited(area):
	player_in_area = false

extends StaticBody2D

var input_hint = preload("res://scenes/resources/input_hint.tscn")
var input_hint_instance : Control
@onready var character = $"."
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

func run_dialogue():
	Dialogic.start("testperson_greeting")
	input_hint_instance.queue_free()
	dialogue_enabled = false
	Dialogic.timeline_ended.connect(dialogue_ended)
	

func dialogue_ended():
	dialogue_enabled = true
	Dialogic.timeline_ended.disconnect(dialogue_ended)
	
func _on_actionable_area_entered(area):
	input_hint_instance = input_hint.instantiate()
	character.add_child(input_hint_instance)
	player_in_area = true


func _on_actionable_area_exited(area):
	if is_instance_valid(input_hint_instance):
		input_hint_instance.queue_free()
	player_in_area = false

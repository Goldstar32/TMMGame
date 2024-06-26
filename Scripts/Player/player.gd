extends CharacterBody2D

@export var speed : int = 120 # speed in pixels/sec
@onready var animations = $AnimationPlayer

func handle_input():
	var move_direction = Input.get_vector("left", "right", "up", "down")
	velocity = move_direction * speed

func update_animation():
	if velocity.length() == 0:
		animations.play("idle_down")
		animations.stop()
	else:
		var direction = "down"
		if velocity.x < 0: direction = "down" # actually left
		elif velocity.x > 0: direction = "down" # actually right
		elif velocity.y < 0: direction = "down" # actually up
	
		animations.play("walk_" + direction)

func _physics_process(delta):
	handle_input()
	move_and_slide()
	update_animation()

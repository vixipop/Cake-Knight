extends CharacterBody2D

@export var gravity = 400
@export var speed = 125
@export var jump_force = 200

@onready var animated_sprite = $AnimatedSprite2D

func _physics_process(delta):
	#Gravity system
	if !is_on_floor():
		velocity.y += gravity * delta
		if velocity.y > 500:
			velocity.y = 500
			
	#Movement (Jump)
	if Input.is_action_just_pressed("jump"): #&& is_on_floor():
		velocity.y = -jump_force
		
#Movement (Left + right)
	var direction = Input.get_axis("move left", "move right")
	#Flipping the sprite
	if direction != 0: 
		animated_sprite.flip_h = (direction == -1)
	velocity.x = direction * speed
	move_and_slide()
	update_animations(direction)
	
func update_animations(direction):
	if is_on_floor():
		if direction == 0:
			animated_sprite.play("idle")
		else:
			animated_sprite.play("walk")
			
	else:
		if velocity.y < 0:
			animated_sprite.play("jump")
		else: 
			animated_sprite.play("fall")
	

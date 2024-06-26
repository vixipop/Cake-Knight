extends CharacterBody2D

@export var gravity = 400
@export var speed = 125
@export var jump_force = 200

@onready var animated_sprite = $AnimatedSprite2D

var attacking: bool = false
var cooldown: bool = false

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
	
	
	#player attack for all directions. a bit janky still.
	#not sure if this should be its own function cause i havent learned how functions work yet
	
	if Input.is_action_just_pressed("attack"):
		if cooldown: return
		if Input.is_action_pressed("down"): 
			attacking = true
			cooldown = true
			$AttackCooldown.start()
			animated_sprite.play("down attack")
			$DownAttack/CollisionShape2D.disabled = false
			await animated_sprite.animation_finished
			attacking = false
		elif Input.is_action_pressed("up"):
			attacking = true
			cooldown = true
			$AttackCooldown.start()
			animated_sprite.play("up attack")
			$UpAttack/CollisionShape2D.disabled = false
			await animated_sprite.animation_finished
			attacking = false
		else:
			attacking = true
			cooldown = true
			$AttackCooldown.start()
			$Attack/CollisionShape2D.disabled = false
			animated_sprite.play("attack")
			await animated_sprite.animation_finished
			attacking = false
	
	#disables attack hitboxes after they were enabled
	if cooldown:
		$DownAttack/CollisionShape2D.disabled = true
		$UpAttack/CollisionShape2D.disabled = true
		$Attack/CollisionShape2D.disabled = true





func update_animations(direction):
	if attacking: return
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
	

#will be used to detect if the player was hit
func _on_damage_detection_body_entered(body):
	pass

#this is the attacks cooldown
func _on_attack_cooldown_timeout():
	cooldown = false


#this is used to pogo off of enemies and the mouse.
func _on_down_attack_area_entered(area):
	velocity.y -= velocity.y + jump_force
	return



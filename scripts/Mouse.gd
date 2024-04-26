extends CharacterBody2D

var bounce: bool = true
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


#this lets us track the mouse as a node
func _process(_delta):
	global_position = get_global_mouse_position()
	
	
	
	#part of an attempt to add a cooldown but it doesnt quite work
	
	#if not bounce:
		#$MouseHitbox/CollisionShape2D.disabled = true
		#$PogoTimer.start()
	#if bounce:
		#$MouseHitbox/CollisionShape2D.disabled = false

#part of an attempt to add a cooldown but it doesnt quite work
func _on_pogo_timer_timeout():
	pass
	#bounce = true

#part of an attempt to add a cooldown but it doesnt quite work
func _on_mouse_hitbox_area_entered(area):
	pass
	#if area.name == "DownAttack":
		#bounce = false


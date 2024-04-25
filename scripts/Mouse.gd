extends CharacterBody2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


#this lets us track the mouse
func _process(_delta):
	global_position = get_global_mouse_position()


#i intend to develop its hit functions here



func _on_mouse_hitbox_area_entered(area):
	print("ow you hurt me!")

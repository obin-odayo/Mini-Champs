extends CharacterBody2D

# character traits variables
var health = 1000
var speed = 300
var damage = 10

# attacking variables
var cursorHover = false

# signal
signal checkIfOnHover

func _on_area_2d_mouse_entered():
	if not cursorHover:
		cursorHover = true
		emit_signal("checkIfOnHover", cursorHover)


func _on_area_2d_mouse_exited():    
	if cursorHover:
		cursorHover = false
		emit_signal("checkIfOnHover", cursorHover)

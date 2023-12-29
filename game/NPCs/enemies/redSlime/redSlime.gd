extends CharacterBody2D

# character traits variables
var health = 1000
var speed = 300
var damage = 10

# attacking variables
var cursorHover = false

# signal
signal checkIfOnHover

func _on_control_mouse_entered():
	cursorHover = true
	emit_signal("checkIfOnHover", cursorHover)

func _on_control_mouse_exited():
	cursorHover = false
	emit_signal("checkIfOnHover", cursorHover)


extends CharacterBody2D

var speed = 300
var target = Vector2() # sets the mouse click position to an ordered pair

func _input(event):
	
	if event.is_action_pressed('moveClick'):
		target = get_global_mouse_position()

func _physics_process(delta):
	# see comment in var target
	# print(target)	
	
	# move the player to the target 	
	velocity = (target - position).normalized() * speed
	
	# rotate the player based on the location of the target
	# TODO: in the future run a specific sprite animation based on the rotation of the player.
	# because what this does is that it ROTATES the player in the 2d plane but the character
	# does not "move/look around."
	rotation = velocity.angle()
	
	# move the player if they're not in the target yet
	if (target - position).length() > 5:
		# print("move")
		move_and_slide()
	# else:
		# print("stop")

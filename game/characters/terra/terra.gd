extends CharacterBody2D

# player traits variables
var health = 1000
var speed = 300
var damage = 10
var attackSpeed = 5

# player controls variables

var playerAttack = false # if player is attacking
var attackCD = false # for attack speed
var attackCDStart # start of the CD timer
var attackCDEnd # end of the CD timer
var enemyInRange = false # for checking if enemy is in range

var playerMove = false # if player is moving
var target = position # for storing the cursor location for move and click



# if body enters check if it is an enemy
# if enemyInRange is false and body inside is an enemy
# make enemyInRange true
func _on_area_attack_body_entered(body):
	if body.is_in_group("Enemies"):
		if not enemyInRange: # this is so that only one instance of this code runs
			enemyInRange = true
			print("_DEBUG: Update, Enemy entered")

# if body exists check if it is an enemy
# if enemyInRange is true and body is an enemy
# make enemyInRangeFalse
func _on_area_attack_body_exited(body):
	if body.is_in_group("Enemies"):
		if enemyInRange:
			enemyInRange = false
			print("_DEBUG: Update, Enemy exited")

# player attacking an enemy function
# if player attacks an enemy they cannot make another attack for a couple of seconds
# this attack interval is determined by attackSpeed
# ---   (hence, if attackSpeed is 1, they can only attack 1 per second).
func attackEnemy():
	pass

func _input(event):
	# if player presses mainClick (right mouse button)
	if event.is_action_pressed("mainClick"):
		# if enemy is in range make playerAttack true
		if enemyInRange:
			playerAttack = true
		
		# if not, then make mouse position as target
		# and make playerMove true
		else:
			target = get_global_mouse_position()
			playerMove = true

func _physics_process(delta):
	# player attacking interval
	if attackCD:
		# get the current time
		attackCDEnd = Time.get_ticks_msec()
		
		# get the time elapsed and convert it from MS to S
		# ---   MS to S : 1 MS / 1000 S
		var attackCDElapsed = (attackCDEnd - attackCDStart) / 1000
		
		# if elapsed time is greater than or equal to AttackSpeed
		# make CD false
		if attackCDElapsed >= attackSpeed:
			attackCD = false 
	
	# if playerAttack is true (from _input())
	# and if attackCD is not true
	# then execute attackEnemy()
	if playerAttack and not attackCD:
		print("_DEBUG: Action, Attacking enemy")
		attackEnemy()
		playerAttack = false
		attackCD = true
		
		# get the time in MS at the instant the attack is in cooldown.
		attackCDStart = Time.get_ticks_msec()
		
	# if playerMove is true (from _input()) then move player to target
	elif playerAttack and attackCD:
		print("_DEBUG: Action, Cannot attack")
		playerAttack = false
	elif playerMove:
		# set velocity to the angle of the position and speed
		velocity = position.direction_to(target) * speed
		
		# change player angle to look at target
		# TODO change this later on to play a different animation depending
		# ---  on the players target angle.
		look_at(target)
		
		# move the player until they reach the target
		if position.distance_to(target) > 10:
			move_and_slide()

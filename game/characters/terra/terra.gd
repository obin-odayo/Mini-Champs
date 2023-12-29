extends CharacterBody2D

var health = 1000
var speed = 300

var target = position

var enemyInRange = false
var playerMove = false
var playerAttack = false

func _on_area_attack_body_entered(body):
	if body.name == "Enemy":
		enemyInRange = true
	else:
		enemyInRange = false

func _on_area_attack_body_exited(_body):
	enemyInRange = false

func attackEnemy():
	var space = get_world_2d().direct_space_state
	var mousePos = get_global_mouse_position()
	var HoverOnEnemy = space.intersect_point(mousePos)
	var collider = HoverOnEnemy.collider
	
	if HoverOnEnemy and collider.is_in_group("Enemies"):
		return true
	return false

func _input(event):
	if event.is_action_pressed("mainClick"):
		target = get_global_mouse_position()
		
		if enemyInRange:
			playerAttack = true
		else:
			playerMove = true

func _physics_process(_delta):
	if playerAttack:
		attackEnemy()
	elif playerMove:
		velocity = position.direction_to(target) * speed
		if position.distance_to(target) > 10:
			move_and_slide()

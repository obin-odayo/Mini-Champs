extends CharacterBody2D

var health = 1000
var speed = 300
var damage = 10

func _ready():
	add_to_group("Enemies")

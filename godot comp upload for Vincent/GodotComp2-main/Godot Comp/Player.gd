extends KinematicBody2D



var gravity =10
var velocity = Vector2.ZERO
var score = 0
var direction = 0
onready var projectile = preload("res://projectile.tscn")

func _ready():
	pass # 
func _process(delta):
	pass
	
func add_score():
	score +=1
	UiSingleton.update_score(score)
	AudioStreamPlayerSingleton.play_sound()
	pass

	
func _physics_process(delta):
	if Input.is_action_pressed("ui_right"):
		$AnimatedSprite.animation = "walk"
		velocity.x += 10
		direction = "right"
		$AnimatedSprite.flip_h = true
		pass
	elif Input.is_action_pressed("ui_left"):
		$AnimatedSprite.animation = "walk"
		velocity.x -= 10
		direction = "left"
		$AnimatedSprite.flip_h = false
		pass
	else:
		$AnimatedSprite.animation = "idle"
		velocity.x = 0
	if Input.is_action_just_pressed("jump") and is_on_floor():
		$AnimatedSprite.animation = "jump"
		velocity.y -= 300
	if Input.is_action_just_pressed("attack"):
		$AnimatedSprite.animation = "attack"
		fire(direction)
		pass
		
	velocity.y += gravity
	velocity = move_and_slide(velocity, Vector2.UP)
	pass

func fire(face):
	var bullet = projectile.instance();
	bullet.position= position
	get_parent().add_child(bullet)
	pass


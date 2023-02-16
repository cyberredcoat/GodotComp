extends KinematicBody2D


onready var health = max_health setget _set_health
export (float) var max_health = 3
signal health_updated(health)
signal killed()

var gravity =10
var velocity = Vector2.ZERO
var score = 0
var direction = "right"

onready var InvulnerabilityTimer = $InvulnerabilityTimer
onready var effects_animation = $AnimationPlayer
onready var player = "Player"


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
	elif Input.is_action_just_pressed("attack"):
		$AnimatedSprite.animation = "attack"
		pass
	else:
		$AnimatedSprite.animation = "idle"
		velocity.x = 0
	velocity.y += gravity
	velocity = move_and_slide(velocity, Vector2.UP)
	pass
	if Input.is_action_just_pressed("jump") and is_on_floor():
		$AnimatedSprite.animation = "jump"
		velocity.y -= 300
	





func die():
	$AnimatedSprite2.animation = "die"

func damage(amount):
	if InvulnerabilityTimer.is_stopped():
		InvulnerabilityTimer.start()
		_set_health(health -amount)
		effects_animation.play("damage")
		effects_animation.queue("visible")


func _set_health(value):
	var prev_health = health
	health = clamp(value,0,max_health)
	if health !=prev_health:
		emit_signal("health_updated", health)
		if health==0:
			player.queue_free()

func _on_InvulnerabilityTimer_timeout():
	effects_animation.play("rest")



#func _on_Area2D_body_entered(body):
	#if Input.is_action_just_pressed("attack"):
		#$AnimatedSprite.animation = "attack"
	#if body.get_name() == "EnemyAINew":
		#if Input.is_action_just_pressed("attack"):
			#$AnimatedSprite.animation = "attack"
			#body.queue_free()
		#else:
			#pass
	#else:
		#pass

		
#func _on_Area2D_body_entered(body):
	#if body.get_name() == "EnemyAINew":
		#damage(1)

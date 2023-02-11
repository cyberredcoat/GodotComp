extends KinematicBody2D



var gravity =10
var velocity = Vector2.ZERO


func _ready():
	pass # 
func _process(delta):
	pass


	
func _physics_process(delta):
	if Input.is_action_pressed("ui_right"):
		velocity.x += 10

	elif Input.is_action_pressed("ui_left"):
		velocity.x -= 10
	else:
		velocity.x = 0
	if Input.is_action_just_pressed("jump") and is_on_floor():
		print(velocity.y)
		velocity.y -= 300

	velocity.y += gravity
	velocity = move_and_slide(velocity, Vector2.UP)

	pass



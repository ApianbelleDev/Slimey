extends CharacterBody2D

@export var speed = 4000
@export var jump_speed = -250
@export var gravity = 500
@export var is_moving = false

func _physics_process(delta):

	# To allow controlling the jump height, instantly set the velocity when the jump key is released.
	# Some recommend quadrupling the gravity instead.
	if not is_on_floor() and Input.is_action_just_released("jump") and velocity.y < -50:
		velocity.y = -50


	#add gravity downwards every frame
	velocity.y += gravity * delta
	
	velocity.x = Input.get_axis("move_left", "move_right") * speed * delta

	if velocity.x != 0:
		is_moving = true
	else:
		is_moving = false
	
	move_and_slide()
	
	#Only allow jumping when on ground
	if Input.is_action_pressed("jump") and is_on_floor():
		velocity.y = jump_speed

	print(is_moving)

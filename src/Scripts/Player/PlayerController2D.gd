extends KinematicBody2D

#global variables
export (int) var speed = 50
export (int) var gravity = 350

var velocity := Vector2.ZERO
var jumping = false;

func _ready():
	print(velocity.y)
	
#gets the input of the player and creates movement
func update_x():
	velocity.x = 0
	if Input.is_action_pressed("walk_right"):
		velocity.x += speed
	if Input.is_action_pressed("walk_left"):
		velocity.x -= speed
	if Input.is_action_just_pressed("ui_cancel"):
		get_tree().quit()
	

func _physics_process(delta):
	update_x()
	# If touching the ground, refresh the jump counter and set current animation state to idle.
	if is_on_floor():
		jumping = false

	# Should we jump?
	if Input.is_action_just_pressed("jump"):
		jumping = true
		velocity.y = -170

		

	# To allow controlling the jump height, instantly set the velocity when the jump key is released.
	# Some recommend quadrupling the gravity instead.
	if not is_on_floor() and Input.is_action_just_released("jump") and velocity.y < -50:
		velocity.y = -50

	velocity.y += gravity * delta
	
	velocity = move_and_slide(velocity, Vector2.UP) 

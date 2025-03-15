extends CharacterBody2D

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@export var speed : float = 400.0
@export var dashSpeed : float = 1600.0
@export_range(0,1) var deceleration : float= 0.4
@export_range(0,1) var acceleration = 0.4
@export var jumpForce= -620
@export_range(0,1) var decelerationOnJumpRelease = 0.5
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var lastDireaction: int

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		if velocity.y < 0:
			velocity.y += gravity * delta
		else:
			velocity.y += (gravity + 200) * delta
			
			

	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = jumpForce
		
	if Input.is_action_just_released("jump") and velocity.y < 0:
		velocity.y *= decelerationOnJumpRelease

	var direction := Input.get_axis("left", "right")
	if direction:
		velocity.x = move_toward(velocity.x, direction * speed, speed * acceleration)
		lastDireaction = direction
		if direction == 1:
			animated_sprite_2d.flip_h = false
		else:
			animated_sprite_2d.flip_h = true
			
	else:
		velocity.x = move_toward(velocity.x, 0, speed * deceleration)
		
	if not is_on_floor():
		animated_sprite_2d.animation = "jump"
	else:
		if direction:
			animated_sprite_2d.animation = "walk"
		else:
			animated_sprite_2d.animation = "idle"
		
	if Input.is_action_just_pressed("dash"):
		velocity.x += dashSpeed * lastDireaction
		velocity.y = 0
		

	move_and_slide()

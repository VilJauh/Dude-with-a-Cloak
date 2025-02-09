extends CharacterBody2D
class_name Player

@export var speed : float = 150
@export var acceleration : float = 1000
@export var friction : float = 1000
@export var crouch_speed : float = 75
@export var jump_velocity : float = -350
@export var wall_jump_velocity : float = -350
@export var wall_jump_push : float = 300
@export var wall_slide_gravity : float = 70
@export var wall_sliding : bool = false
@export var coyote_time : float = 0.2
@export var gravity : int = 1000
@export var jump_buffer_time : int = 10
@export var jump_pad : float = -600
@export var can_jump : bool = false

@onready var animated_sprite = $AnimatedSprite2D
@onready var cshape = $CollisionShape2D
@onready var crounchRaycast1 = $CrouchRaycast1
@onready var crounchRaycast2 = $CrouchRaycast2
@onready var wallDetectionRight = $WallDetectionRight
@onready var wallDetectionLeft = $WallDetectionLeft
@onready var landing : bool = false
@onready var walking_sound = $audio/walkingSound
@onready var jump_sound = $audio/jump
@onready var land_sound = $audio/land
@onready var death_sound = $audio/Death
@onready var wall_slide_particles = $AnimatedSprite2D/CPUParticles2D
@onready var landing_particles = $AnimatedSprite2D/CPUParticles2D2
@onready var death_particles = $CPUParticles2D3
@onready var death_timer = $DeathTimer
@onready var start_countdown_timer = $StartCountdown
@onready var starts_in = $Camera2D/CanvasLayer/Control


var playerDead : bool = false
var jump_buffer_counter: int = 0
var crouching : bool = false
var under_object : bool = false
var wall_colliding : bool = false
var animation_locked : bool = false
var wall_slide_start : bool = false

var standing_collision = preload("res://recources/player_standing_cshape.tres")
var crouching_collision = preload("res://recources/player_crouching_chsape.tres")

@onready var main = $"../"

func _ready():
	GameManager.player = self
	animation_locked = true
	start_countdown_timer.start()
	
func _physics_process(delta):
	_movement(delta)
	_coyote_time()
	_jump()
	_wall_jump()
	_crouch()
	_standing()
	_wall_slide()
	_wall_detection()
	_update_animation()
	_update_facing_direction()
	_walking_sound()
	move_and_slide()
	if main.timer_on == false and Input.is_action_just_pressed("jump") and starts_in.visible == true:
		main.timer_on = true
		animation_locked = false
		starts_in.visible = false
		main.starting = false
		start_countdown_timer.stop()

func _movement(delta):
	if not animation_locked:
		var input_x = Input.get_action_strength("right") - Input.get_action_strength("left")
		if input_x != 0 and crouching == false:
			velocity.x = move_toward(velocity.x, input_x * speed, acceleration * delta)
		elif input_x != 0 and crouching == true:
			velocity.x = move_toward(velocity.x, input_x * crouch_speed, acceleration * delta)
		else:
			velocity.x = move_toward(velocity.x, 0.0, friction * delta)
		if not is_on_floor():
			velocity.y += gravity * delta
		if is_on_floor():
			if landing:
				land_sound.pitch_scale = randf_range(3.7,4)
				land_sound.play()
				landing_particles.emitting = true
				landing = false
		else:
			if !landing:
				landing = true

func _walking_sound():
	if velocity.x != 0 and is_on_floor():
		if $audio/Timer.time_left <= 0 and crouching == false:
			walking_sound.pitch_scale = randf_range(0.90,0.95)
			walking_sound.play()
			$audio/Timer.start(0.2)
		elif $audio/Timer.time_left <= 0 and crouching == true:
			walking_sound.pitch_scale = randf_range(0.82,0.85)
			walking_sound.play()
			$audio/Timer.start(0.25)

func jumping_sound():
	if animation_locked == false:
		jump_sound.pitch_scale = randf_range(1.32,1.35)
		jump_sound.play()
	
func _update_animation():
	if not animation_locked:
		if velocity.x != 0 and velocity.y == 0 and crouching == false:
			animated_sprite.play("Run")
		if velocity.x != 0 and velocity.y == 0 and crouching == true:
			animated_sprite.play("Crouching")
		if velocity.x == 0 and velocity.y == 0 and crouching == false:
			animated_sprite.play("Idle")
		if velocity.x == 0 and velocity.y == 0 and crouching == true:
			animated_sprite.play("CrouchingIdle")
		if velocity.y < 0:
			animated_sprite.play("Flying")
		if velocity.y > 0 and wall_sliding == false:
			animated_sprite.play("Falling")
		if velocity.y > 0 and wall_sliding == true:
			animated_sprite.play("Wallslide")
			wall_slide_particles.emitting = true
		else:
			wall_slide_particles.emitting = false
		
func _update_facing_direction():
	if velocity.x > 0:
		animated_sprite.flip_h = false
		wall_slide_particles.position.x = 5
	elif velocity.x < 0:
		animated_sprite.flip_h = true
		wall_slide_particles.position.x = -5

func _coyote_time():
	if is_on_floor():
		$CoyoteTimer.start()
		can_jump = true

func _jump():
	if not animation_locked:
		if Input.is_action_just_pressed("jump") and _crouch_detection() == true:
			jump_buffer_counter = jump_buffer_time
		if jump_buffer_counter > 0:
			jump_buffer_counter -= 1
		if jump_buffer_counter > 0 and can_jump == true:
			velocity.y = jump_velocity
			jumping_sound()
			can_jump = false
			jump_buffer_counter = 0

func _wall_jump():
	if Input.is_action_just_pressed("jump"):
		if wall_sliding == true and wallDetectionLeft.is_colliding():
			velocity.x += wall_jump_push
			velocity.y = wall_jump_velocity
			jumping_sound()
		elif wall_sliding == true and wallDetectionRight.is_colliding():
			velocity.x += -wall_jump_push
			velocity.y = wall_jump_velocity
			jumping_sound()
			
func _crouch_detection() -> bool:
	var result = !crounchRaycast1.is_colliding() and !crounchRaycast2.is_colliding()
	return result
	
func _crouch():
	if is_on_floor() and Input.is_action_pressed("down"):
		crouching = true
		cshape.shape = crouching_collision
		cshape.position.y = 8
	if !is_on_floor():
		crouching = false
	if Input.is_action_just_released("down"):
		if _crouch_detection():
			crouching = false
		else:
			if under_object != true:
				under_object = true
	if under_object and _crouch_detection():
		crouching = false
		under_object = false
		
func _standing():
	if crouching == false:
		cshape.shape = standing_collision
		cshape.position.y = 3.5
	
func _wall_slide():
	if _wall_detection() and !Input.is_action_pressed("down") and velocity.y > 0:
		wall_sliding = true
	elif _wall_detection() and Input.is_action_pressed("down"):
		wall_sliding = false
	else:
		wall_sliding = false
	if is_on_floor():
		wall_sliding = false
	if wall_sliding == true and velocity.y > 0:
		velocity.y = min(velocity.y, wall_slide_gravity)
	if wall_sliding == true:
		if wall_slide_start == true:
			wall_slide_start = false
	else:
		if wall_slide_start == false:
			wall_slide_start = true
		
func _wall_detection() -> bool:
	var result = wallDetectionRight.is_colliding() or wallDetectionLeft.is_colliding()
	return result

func die():
	playerDead = true
	animation_locked = true
	death_sound.pitch_scale = randf_range(1.0,1.05)
	death_sound.play()
	animated_sprite.hide()
	death_particles.emitting = true
	velocity.x = 0
	velocity.y = 0
	death_timer.start()

func jump_platform():
	velocity.y = jump_pad

func _on_coyote_timer_timeout():
	can_jump = false

func _on_death_timer_timeout():
	playerDead = false
	GameManager.respawn_player()

func _on_start_countdown_timeout():
	main.timer_on = true
	animation_locked = false
	main.starting = false
	starts_in.visible = false

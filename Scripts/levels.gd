extends Node2D

@onready var pause_menu_layer = $Player/Camera2D/CanvasLayer/PauseMenu/CanvasLayer
@onready var level_timer = $Player/Camera2D/CanvasLayer/LevelTimer
@onready var level_completed_layer = $LevelEnd/LevelCompleted/CanvasLayer
@onready var click = $LevelEnd/LevelCompleted/click
@onready var player = $Player
@onready var LevelEnd = $LevelEnd

var level_passed = false
var final_time_float: float
var timer_on = true
var time = 0
var starting = true

func _ready():
	timer_on = false
	starting = true

func _process(delta):
	if Input.is_action_just_pressed("pause") and starting == false and level_passed == false:
		PauseMenu()
		
	if timer_on == true:
		time += delta
		if Input.is_action_just_pressed("reset"):
			get_tree().reload_current_scene()
		
	var mils = fmod(time,1)*1000
	var secs = fmod(time,6000)
	
	var time_passed = "%4d.%03d" % [secs,mils]
	if timer_on == true:
		level_timer.text = time_passed
	final_time_float = time
	if secs > 6000:
		get_tree().change_scene_to_file("res://Scenes/levels_menu.tscn")
	
func PauseMenu():
	if timer_on == false:
		GameManager.lock_player()
		timer_on = true
		pause_menu_layer.hide()
		Engine.time_scale = 1
		pause_menu_layer.set_layer(2)
		level_completed_layer.set_layer(3)
	else:
		GameManager.lock_player()
		timer_on = false
		pause_menu_layer.show()
		level_completed_layer.set_layer(2)
		pause_menu_layer.set_layer(3)
		Engine.time_scale = 0

func end_of_level():
	timer_on = false
	player.velocity.x = 0
	player.velocity.y = 0
	var tween = create_tween().set_parallel(true)
	tween.tween_property(player, "position", LevelEnd.position, 1)
	tween.tween_property(player, "rotation_degrees", 720, 1.5)
	tween.tween_property(player, "scale", Vector2(0,0), 1.5)
	player.animated_sprite.play("Idle")
	level_passed = true
	player.animation_locked = true
	level_timer.text = str(snapped(time, 0.001))
	GameManager.last_time = final_time_float
	GameManager.levels_cleared()

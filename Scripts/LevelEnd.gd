extends Area2D

@export var level_cleared = false
@onready var main = $"../"
@onready var pb_text = $LevelCompleted/CanvasLayer/PB
@onready var level_completed = $LevelCompleted/CanvasLayer
var entered = false
var personal_best_time: float

func _on_body_entered(_body: PhysicsBody2D):
	entered = true
	main.end_of_level()
	level_completed.show()
	pb_to_show()
	
func pb_to_show():
	var current_level = get_tree().get_current_scene().get_name()
	if current_level == "Level_1":
		pb_text.text = "Personal Best: " + str(snapped(GameManager.level1_best_time, 0.001))
		print(GameManager.level1_best_time)
	if current_level == "Level_2":
		pb_text.text = "Personal Best: " + str(snapped(GameManager.level2_best_time, 0.001))
		print(GameManager.level2_best_time)
	if current_level == "Level_3":
		pb_text.text = "Personal Best: " + str(snapped(GameManager.level3_best_time, 0.001))
		print(GameManager.level3_best_time)
	if current_level == "Level_4":
		pb_text.text = "Personal Best: " + str(snapped(GameManager.level4_best_time, 0.001))
		print(GameManager.level4_best_time)
	if current_level == "Level_5":
		pb_text.text = "Personal Best: " + str(snapped(GameManager.level5_best_time, 0.001))
		print(GameManager.level5_best_time)

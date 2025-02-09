extends Control

@onready var click = $click
@onready var star = $StarBg/Star
@onready var star2 = $StarBg2/Star2
@onready var star3 = $StarBg3/Star3

@onready var current_level = $Current_level
@onready var personal_best = $Personal_best
@onready var locked = $Locked

var level2_unlock = 1
var level3_unlock = 4
var level4_unlock = 7
var level5_unlock = 10

var entering = false

func _ready():
	GameManager.save()
	GameManager.total_stars = GameManager.level1_stars + GameManager.level2_stars + GameManager.level3_stars + GameManager.level4_stars + GameManager.level5_stars
	entering = true
	last_level()
	entering = false

func last_level():
		if GameManager.last_level == 1:
			_on_level_1_mouse_entered()
		if GameManager.last_level == 2:
			_on_level_2_mouse_entered()
		if GameManager.last_level == 3:
			_on_level_3_mouse_entered()
		if GameManager.last_level == 4:
			_on_level_4_mouse_entered()
		if GameManager.last_level == 5:
			_on_level_5_mouse_entered()

func _on_level_1_pressed():
	get_tree().change_scene_to_file("res://Scenes/level_1.tscn")

func _on_level_2_pressed():
	if GameManager.total_stars >= 1:
		get_tree().change_scene_to_file("res://Scenes/level_2.tscn")

func _on_level_3_pressed():
	if GameManager.total_stars >= 3:
		get_tree().change_scene_to_file("res://Scenes/level_3.tscn")

func _on_level_4_pressed():
	if GameManager.total_stars >= 6:
		get_tree().change_scene_to_file("res://Scenes/level_4.tscn")

func _on_level_5_pressed():
	if GameManager.total_stars >= 9:
		get_tree().change_scene_to_file("res://Scenes/level_5.tscn")

func _on_back_pressed():
	get_tree().change_scene_to_file("res://Scenes/main_menu.tscn")

func _on_level_1_mouse_entered():
	if entering == false:
		click.play()
	current_level.text = "Level 1"
	locked.visible = false
	if GameManager.level1_best_time == 0:
		personal_best.text = "Personal Best: No time"
	else:
		personal_best.text = "Personal Best: " + str(snapped(GameManager.level1_best_time, 0.001))
	if GameManager.level1_stars == 0:
		star.visible = false
		star2.visible = false
		star3.visible = false
	if GameManager.level1_stars == 1:
		star.visible = true
		star2.visible = false
		star3.visible = false
	if GameManager.level1_stars == 2:
		star.visible = true
		star2.visible = true
		star3.visible = false
	if GameManager.level1_stars == 3:
		star.visible = true
		star2.visible = true
		star3.visible = true

func _on_level_2_mouse_entered():
	if entering == false:
		click.play()
	current_level.text = "Level 2"
	if GameManager.total_stars < level2_unlock:
		locked.visible = true
		locked.text = "Locked " + str(GameManager.total_stars) + "/" + str(level2_unlock)
	else:
		locked.visible = false
	if GameManager.level2_best_time == 0:
		personal_best.text = "Personal Best: No time"
	else:
		personal_best.text = "Personal Best: " + str(snapped(GameManager.level2_best_time, 0.001))
	if GameManager.level2_stars == 0:
		star.visible = false
		star2.visible = false
		star3.visible = false
	if GameManager.level2_stars == 1:
		star.visible = true
		star2.visible = false
		star3.visible = false
	if GameManager.level2_stars == 2:
		star.visible = true
		star2.visible = true
		star3.visible = false
	if GameManager.level2_stars == 3:
		star.visible = true
		star2.visible = true
		star3.visible = true

func _on_level_3_mouse_entered():
	if entering == false:
		click.play()
	current_level.text = "Level 3"
	if GameManager.total_stars < level3_unlock:
		locked.visible = true
		locked.text = "Locked " + str(GameManager.total_stars) + "/" + str(level3_unlock)
	else:
		locked.visible = false
	if GameManager.level3_best_time == 0:
		personal_best.text = "Personal Best: No time"
	else:
		personal_best.text = "Personal Best: " + str(snapped(GameManager.level3_best_time, 0.001))
	if GameManager.level3_stars == 0:
		star.visible = false
		star2.visible = false
		star3.visible = false
	if GameManager.level3_stars == 1:
		star.visible = true
		star2.visible = false
		star3.visible = false
	if GameManager.level3_stars == 2:
		star.visible = true
		star2.visible = true
		star3.visible = false
	if GameManager.level3_stars == 3:
		star.visible = true
		star2.visible = true
		star3.visible = true

func _on_level_4_mouse_entered():
	if entering == false:
		click.play()
	current_level.text = "Level 4"
	if GameManager.total_stars < level4_unlock:
		locked.visible = true
		locked.text = "Locked " + str(GameManager.total_stars) + "/" + str(level4_unlock)
	else:
		locked.visible = false
	if GameManager.level4_best_time == 0:
		personal_best.text = "Personal Best: No time"
	else:
		personal_best.text = "Personal Best: " + str(snapped(GameManager.level4_best_time, 0.001))
	if GameManager.level4_stars == 0:
		star.visible = false
		star2.visible = false
		star3.visible = false
	if GameManager.level4_stars == 1:
		star.visible = true
		star2.visible = false
		star3.visible = false
	if GameManager.level4_stars == 2:
		star.visible = true
		star2.visible = true
		star3.visible = false
	if GameManager.level4_stars == 3:
		star.visible = true
		star2.visible = true
		star3.visible = true

func _on_level_5_mouse_entered():
	if entering == false:
		click.play()
	current_level.text = "Level 5"
	if GameManager.total_stars < level5_unlock:
		locked.visible = true
		locked.text = "Locked " + str(GameManager.total_stars) + "/" + str(level5_unlock)
	else:
		locked.visible = false
	if GameManager.level5_best_time == 0:
		personal_best.text = "Personal Best: No time"
	else:
		personal_best.text = "Personal Best: " + str(snapped(GameManager.level5_best_time, 0.001))
	if GameManager.level5_stars == 0:
		star.visible = false
		star2.visible = false
		star3.visible = false
	if GameManager.level5_stars == 1:
		star.visible = true
		star2.visible = false
		star3.visible = false
	if GameManager.level5_stars == 2:
		star.visible = true
		star2.visible = true
		star3.visible = false
	if GameManager.level5_stars == 3:
		star.visible = true
		star2.visible = true
		star3.visible = true

func _on_back_mouse_entered():
		click.play()

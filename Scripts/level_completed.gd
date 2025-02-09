extends Control

@onready var click = $click
@onready var star = $CanvasLayer/star_control/StarBg/Star
@onready var star2 = $CanvasLayer/star_control2/StarBg2/Star2
@onready var star3 = $CanvasLayer/star_control3/StarBg3/Star3
@onready var time_needed = $CanvasLayer/Time_needed
@onready var time_needed2 = $CanvasLayer/Time_needed2
@onready var time_needed3 = $CanvasLayer/Time_needed3


func _process(_delta):
	if get_tree().get_current_scene().get_name() == "Level_1":
		time_needed.text = "Complete level"
		time_needed2.text = "Time under: " + str(GameManager.level1_star2_time) + " sec"
		time_needed3.text = "Time under: " + str(GameManager.level1_star3_time) + " sec"
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
	if get_tree().get_current_scene().get_name() == "Level_2":
		time_needed.text = "Complete level"
		time_needed2.text = "Time under: " + str(GameManager.level2_star2_time) + " sec"
		time_needed3.text = "Time under: " + str(GameManager.level2_star3_time) + " sec"
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
	if get_tree().get_current_scene().get_name() == "Level_3":
		time_needed.text = "Complete level"
		time_needed2.text = "Time under: " + str(GameManager.level3_star2_time) + " sec"
		time_needed3.text = "Time under: " + str(GameManager.level3_star3_time) + " sec"
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
	if get_tree().get_current_scene().get_name() == "Level_4":
		time_needed.text = "Complete level"
		time_needed2.text = "Time under: " + str(GameManager.level4_star2_time) + " sec"
		time_needed3.text = "Time under: " + str(GameManager.level4_star3_time) + " sec"
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
	if get_tree().get_current_scene().get_name() == "Level_5":
		time_needed.text = "Complete level"
		time_needed2.text = "Time under: " + str(GameManager.level5_star2_time) + " sec"
		time_needed3.text = "Time under: " + str(GameManager.level5_star3_time) + " sec"
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
func _on_retry_pressed():
	get_tree().reload_current_scene()
	Engine.time_scale = 1


func _on_level_selection_pressed():
	get_tree().change_scene_to_file("res://Scenes/levels_menu.tscn")
	Engine.time_scale = 1


func _on_star_control_2_mouse_entered():
	time_needed2.visible = true


func _on_star_control_2_mouse_exited():
	time_needed2.visible = false



func _on_star_control_3_mouse_entered():
	time_needed3.visible = true


func _on_star_control_3_mouse_exited():
	time_needed3.visible = false


func _on_star_control_mouse_entered():
	time_needed.visible = true


func _on_star_control_mouse_exited():
	time_needed.visible = false



func _on_retry_mouse_entered():
	click.play()


func _on_level_selection_mouse_entered():
	click.play()

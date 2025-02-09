extends Node

var current_checkpoint : Checkpoint

var player : Player
var save_path = "user://variable.save"

var last_time: float
var level1_best_time: float
var level1_stars: int = 0
var level1_star2_time: float = 21
var level1_star3_time: float = 15
var level2_best_time: float
var level2_stars: int = 0
var level2_star2_time: float = 39
var level2_star3_time: float = 26
var level3_best_time: float
var level3_stars: int = 0
var level3_star2_time: float = 41
var level3_star3_time: float = 20
var level4_best_time: float
var level4_stars: int = 0
var level4_star2_time: float = 59
var level4_star3_time: float = 37
var level5_best_time: float
var level5_stars: int = 0
var level5_star2_time: float = 58
var level5_star3_time: float = 29
var total_stars: int = 0
var last_level = 1

func respawn_player():
	if current_checkpoint != null:
		lock_player()
		player.animated_sprite.show()
		player.global_position = current_checkpoint.global_position
	else:
		get_tree().reload_current_scene()
func lock_player():
	if player.animation_locked == true:
		player.animation_locked = false
	else:
		player.animation_locked = true
		
func levels_cleared():
	var current_level = get_tree().get_current_scene().get_name()
	if current_level == "Level_1":
		last_level = 1
		if level1_best_time == 0:
			level1_best_time = last_time
		elif last_time < level1_best_time:
			level1_best_time = last_time
		if level1_best_time < level1_star3_time:
			level1_stars = 3
		if level1_best_time >= level1_star3_time and level1_best_time < level1_star2_time:
			level1_stars = 2
		if level1_best_time >= level1_star2_time:
			level1_stars = 1
	if current_level == "Level_2":
		last_level = 2
		if level2_best_time == 0:
			level2_best_time = last_time
		elif last_time < level2_best_time:
			level2_best_time = last_time
		if level2_best_time < level2_star3_time:
			level2_stars = 3
		if level2_best_time >= level2_star3_time and level2_best_time < level2_star2_time:
			level2_stars = 2
		if level2_best_time >= level2_star2_time:
			level2_stars = 1
	if current_level == "Level_3":
		last_level = 3
		if level3_best_time == 0:
			level3_best_time = last_time
		elif last_time < level3_best_time:
			level3_best_time = last_time
		if level3_best_time < level3_star3_time:
			level3_stars = 3
		if level3_best_time >= level3_star3_time and level3_best_time < level3_star2_time:
			level3_stars = 2
		if level3_best_time >= level3_star2_time:
			level3_stars = 1
	if current_level == "Level_4":
		last_level = 4
		if level4_best_time == 0:
			level4_best_time = last_time
		elif last_time < level4_best_time:
			level4_best_time = last_time
		if level4_best_time < level4_star3_time:
			level4_stars = 3
		if level4_best_time >= level4_star3_time and level4_best_time < level4_star2_time:
			level4_stars = 2
		if level4_best_time >= level4_star2_time:
			level4_stars = 1
	if current_level == "Level_5":
		last_level = 5
		if level5_best_time == 0:
			level5_best_time = last_time
		elif last_time < level5_best_time:
			level5_best_time = last_time
		if level5_best_time < level5_star3_time:
			level5_stars = 3
		if level5_best_time >= level5_star3_time and level5_best_time < level5_star2_time:
			level5_stars = 2
		if level5_best_time >= level5_star2_time:
			level5_stars = 1

func save():
	var file = FileAccess.open(save_path, FileAccess.WRITE)
	file.store_var(level1_stars)
	file.store_var(level1_best_time)
	file.store_var(level2_stars)
	file.store_var(level2_best_time)
	file.store_var(level3_stars)
	file.store_var(level3_best_time)
	file.store_var(level4_stars)
	file.store_var(level4_best_time)
	file.store_var(level5_stars)
	file.store_var(level5_best_time)
	file.close()

func load_data():
	if FileAccess.file_exists(save_path):
		var file = FileAccess.open(save_path, FileAccess.READ)
		level1_stars = file.get_var(level1_stars)
		level1_best_time = file.get_var(level1_best_time)
		level2_stars = file.get_var(level2_stars)
		level2_best_time = file.get_var(level2_best_time)
		level3_stars = file.get_var(level3_stars)
		level3_best_time = file.get_var(level3_best_time)
		level4_stars = file.get_var(level4_stars)
		level4_best_time = file.get_var(level4_best_time)
		level5_stars = file.get_var(level5_stars)
		level5_best_time = file.get_var(level5_best_time)
		file.close()
	else:
		print("no data saved...")
		level1_stars = 0
		level1_best_time = 0
		level2_stars = 0
		level2_best_time = 0
		level3_stars = 0
		level3_best_time = 0
		level4_stars = 0
		level4_best_time = 0
		level5_stars = 0
		level5_best_time = 0

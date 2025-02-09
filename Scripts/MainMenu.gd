extends Control

@onready var click = $click
	
func _on_play_pressed():
	get_tree().change_scene_to_file("res://Scenes/levels_menu.tscn")
	GameManager.load_data()

func _on_settings_pressed():
	get_tree().change_scene_to_file("res://Scenes/options.tscn")



func _on_play_mouse_entered():
	click.play()


func _on_settings_mouse_entered():
	click.play()

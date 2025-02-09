extends Control

@onready var click = $click
	
func _on_back_pressed():
	click.play()
	get_tree().change_scene_to_file("res://Scenes/main_menu.tscn")


func _on_back_mouse_entered():
	click.play()

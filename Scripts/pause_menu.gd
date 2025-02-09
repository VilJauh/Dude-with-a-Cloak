extends Control

@onready var main = $"../../../../"
@onready var click = $CanvasLayer/click
@onready var player = $"../../../"

func _on_resume_pressed():
	main.PauseMenu()

func _on_quit_pressed():
	get_tree().change_scene_to_file("res://Scenes/levels_menu.tscn")
	Engine.time_scale = 1


func _on_restart_pressed():
	get_tree().reload_current_scene()
	Engine.time_scale = 1


func _on_resume_mouse_entered():
	click.play()


func _on_restart_mouse_entered():
	click.play()


func _on_quit_mouse_entered():
	click.play()



func _on_checkpoint_pressed():
	main.PauseMenu()
	player.die()


func _on_checkpoint_mouse_entered():
	click.play()

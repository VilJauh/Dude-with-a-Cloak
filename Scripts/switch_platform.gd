extends StaticBody2D
class_name Switch

var player = load("res://Scripts/player.gd")
@onready var animationplayer = $AnimationPlayer
@export var switch : bool = true

func _ready():
	switching()
	
func switching():	
	if switch == true:
		switch = false
		notactive()
		return
	if switch == false:
		switch = true
		active()
		return

func active():
	animationplayer.play("Active")

func notactive():
	animationplayer.play("NotActive")

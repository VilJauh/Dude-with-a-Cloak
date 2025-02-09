extends StaticBody2D

@onready var player : Player

@onready var animationplayer2 = $AnimationPlayer2
@onready var animationplayer = $AnimationPlayer

@export var jump_boost = 600

func _on_area_2d_body_entered(body):
	if body.is_in_group("Player"):
		body.jump_platform()
		animationplayer2.play("Bounce")

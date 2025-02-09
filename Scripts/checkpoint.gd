extends Area2D
class_name Checkpoint

@onready var animationplayer = $AnimationPlayer
@onready var animationplayer2 = $AnimationPlayer2
@export var spawnpoint = false

var player : Player
var activated = false

func activate():
	GameManager.current_checkpoint = self
	activated = true
	animation()

func _on_body_entered(body):
	if body.is_in_group("Player"):
		if not activated:
			activate()
func animation():
	animationplayer2.play("Activation")
	animationplayer.play("Activation")
	
func Idle_animation():
	animationplayer.play("Idle")
	

extends Area2D

var player : Player

func _on_body_entered(body):
	if body.is_in_group("Player"):
		body.die()

extends StaticBody2D

@onready var animationplayer = $AnimationPlayer

func _on_area_2d_body_entered(_body: Node) -> void:
	animationplayer.play("Falling")

func regenerate():
	animationplayer.play("Regenerate")

func back_to_static():
	animationplayer.play("Static")

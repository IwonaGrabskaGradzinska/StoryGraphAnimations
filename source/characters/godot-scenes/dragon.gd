extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func death():
	$animation.play("death")
	
func fight():
	$animation.play("fight")

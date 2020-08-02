extends Node2D

func _ready():
	$animation.play("idle")

func talking():
	$animation.play("talking")

func walk():
	$animation.play("walk")

func drop():
	$animation.play("drop")

func idle():
	$animation.play("idle")
	
func rumble():
	$animation.play("rumble")
	
func walkmoving():
	$animation.play("walk (moving)")

func stop():
	$animation.stop()

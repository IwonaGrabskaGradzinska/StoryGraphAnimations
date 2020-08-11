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
	
func scaredrunk():
	$animation.play("scare-drunk")
	
func get_elixir():
	$animation.play("get-elixir")
	
func give_money():
	$animation.play("give-money")	
	
func nod():
	$animation.play("nod")
	
func reach():
	$animation.play("reach")
		
func fight():
	$animation.play("fight")
	
func death():
	$animation.play("death")
	
func cast_spell():
	$animation.play("cast-spell")
	
func pickup_elixir():
	$animation.play("pick-up-item")

func stop():
	$animation.stop()

extends Node2D

export var location: NodePath

func change_scene(new_location: NodePath):
	get_node(location).hide()
	location = new_location
	get_node(location).show()
	pass

extends Sprite

var item

func getReference():
	return item

func _ready():
	var Item = load("res://Item.gd")
	item = Item.newItem(texture)
	var root = get_tree().get_root().get_node("Node2D")
	item.setNodePath(root.get_path_to(self))


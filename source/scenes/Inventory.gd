extends GridContainer

var Item

func _ready():
	pass

func changeSize(delta):
	Item = load("res://Item.gd")
	rect_size = Vector2((columns + delta) * Item.size, Item.size)
	columns = columns + delta

func addItem(item):
	item.get_node("Sprite").flip_h = false
	add_child(item)
	item.rect_position = Vector2(0,0)
	item.change_background(1)
	changeSize(1)

func isEmpty():
	return get_child_count() < 1

func getItem(i):
	var index = get_child_count() - i - 1
	return get_child(index)

func has_item(item):
	if(item == null):
		return false
	else:
		return get_children().has(item)

func removeItem(item):
	if(item != null):
		remove_child(item)
		item.change_background(0)
		changeSize(-1)

func get_positionX ():
	Item = load("res://Item.gd")
	return -(columns/2) * Item.size

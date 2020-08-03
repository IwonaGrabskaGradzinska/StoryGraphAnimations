extends Node2D

export var mainCharacter = true
export var flipped = false
var isFlipped

onready var model_inventory = preload("res://scenes/Inventory.tscn")
const Inventory = preload("res://scenes/Inventory.gd")

var location : NodePath

var inventory : Inventory
var item_in_left_hand
var item_in_right_hand

var primary_weapon : NodePath
var secondary_weapon : NodePath
var primary_weapon_is_set = false
var secondary_weapon_is_set = false

var armor

export var right_hand : NodePath
export var left_hand : NodePath
export var armor_handle : NodePath

var right_hand_node : Node2D
var left_hand_node : Node2D
var armor_handle_node : Node2D


func getRoot():
	return get_tree().get_root().get_node("Node2D")

func getLocation():
	return getRoot().get_node(location)

func getNode(path: NodePath):
	var root = getRoot()
	return root.get_node(path).getReference()
	
func getPath(node):
	return node.getNodePath()


func getReference():
	return self

# Called when the node enters the scene tree for the first time.
func _ready():
	var Item = load("res://Item.gd")
	inventory = model_inventory.instance()
	right_hand_node = get_node(right_hand)
	left_hand_node = get_node(left_hand)
	armor_handle_node = get_node(armor_handle)
	isFlipped = flipped
	
	open_inventory()

func open_inventory():
	add_child(inventory)
	inventory.rect_position = Vector2(inventory.get_positionX(), 5)

func close_inventory():
	remove_child(inventory)

func get_item(item):
	inventory.removeItem(item)
	right_hand_node.remove_child(item)
	left_hand_node.remove_child(item)
	armor_handle_node.remove_child(item)

func give_item(itemPath: NodePath, characterPath: NodePath):
	var item = getNode(itemPath)
	var character = getNode(characterPath)
	get_item(item)
	character.add_item(item)

func add_item_from_path(itemPath: NodePath):
	var item = getNode(itemPath)
	add_item(item)

func add_item(item):
	if item.get_parent() != null:
		item.get_parent().remove_child(item)
	inventory.addItem(item)
	open_inventory()

func set_to_left_hand(itemPath: NodePath):
	var item = getNode(itemPath)
	if inventory.has_item(item):
		get_item(item)
		if flipped:
			item.get_node("Sprite").flip_h = true
		item_in_left_hand = item
		left_hand_node.add_child(item)
		item.rect_position = Vector2(-16,-16)

func set_to_right_hand(itemPath: NodePath):
	var item = getNode(itemPath)
	if inventory.has_item(item):
		get_item(item)
		if flipped:
			item.get_node("Sprite").flip_h = true
		item_in_right_hand = item
		right_hand_node.add_child(item)
		item.rect_position = Vector2(-16,-16)

func equip_armor(armorPath: NodePath):
	var item = getNode(armorPath)
	if inventory.has_item(item):
		get_item(item)
		if flipped:
			item.get_node("Sprite").flip_h = true
		armor = item
		armor_handle_node.add_child(item)

func take_off_armor():
	if armor != null:
		armor_handle_node.remove_child(armor)
		add_item(armor)
		armor = null

func equip_primary_weapon(itemPath: NodePath):
	var item = getNode(itemPath)
	if inventory.has_item(item):
		primary_weapon = itemPath
		primary_weapon_is_set = true

func equip_secondary_weapon(itemPath: NodePath):
	var item = getNode(itemPath)
	if inventory.has_item(item):
		secondary_weapon = itemPath
		secondary_weapon_is_set = true

func equip_hands():
	hide_items()
	if primary_weapon_is_set :
		set_to_right_hand(primary_weapon)
	if secondary_weapon_is_set :
		set_to_left_hand(secondary_weapon)

func hide_left_hand_item():
	if item_in_left_hand != null:
		left_hand_node.remove_child(item_in_left_hand)
		add_item(item_in_left_hand)
		item_in_left_hand = null

func hide_right_hand_item():
	if item_in_right_hand != null:
		right_hand_node.remove_child(item_in_right_hand)
		add_item(item_in_right_hand)
		item_in_right_hand = null

func hide_items():
	hide_left_hand_item()
	hide_right_hand_item()

func dropItem(itemPath: NodePath, offset: float = 0):
	var item = getNode(itemPath)
	drop(item, offset)

func drop(item, offset = 0):
	if item != null:
		item.get_node("Sprite").flip_h = false
		get_item(item)
		getLocation().add_child(item)
		var parentposition = get_parent().transform.get_origin()
		var position: Vector2 = parentposition + transform.get_origin()
		position[0] -= 16 + offset
		position[1] -= 32
		item.rect_position = position

func dropAllItems():
	drop(armor)
	var i = 0
	var j = 1
	while(!inventory.isEmpty()):
		var offset = j * 32
		if i % 2 == 0:
			offset *= -1 
		else:
			j += 1
		drop(inventory.getItem(0), offset)
		i += 1
	drop(item_in_right_hand, j * 32)
	if i % 2 != 0:
		j += 1
	drop(item_in_left_hand, -j * 32)

func set_location(locationPath: NodePath):
	location = locationPath

func move_to_location(locationPath: NodePath):
	location = locationPath
	getLocation().add_child(self)

func _process(delta):
	if isFlipped != flipped:
		isFlipped = flipped
		var rightOffset = right_hand_node.transform.get_origin()[0] - transform.get_origin()[0];
		right_hand_node.translate(Vector2(-2 * rightOffset, 0))
		
		var leftOffset = left_hand_node.transform.get_origin()[0] - transform.get_origin()[0];
		left_hand_node.translate(Vector2(-2 * leftOffset, 0))
	
	
	if item_in_right_hand != null:
		item_in_right_hand.get_node("Sprite").flip_h = flipped
		
	if item_in_left_hand != null:
		item_in_left_hand.get_node("Sprite").flip_h = flipped
		
	if armor != null:
		armor.get_node("Sprite").flip_h = flipped

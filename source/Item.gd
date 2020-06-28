extends PanelContainer

const size = 32

var style: StyleBox = StyleBoxFlat.new()
var nodePath: NodePath

static func newItem(texture):
	var model_container = load("res://scenes/item_scene.tscn")
	var item = model_container.instance()
	item.get_node("Sprite").set_texture(texture)
	return item

func setNodePath(path: NodePath):
	nodePath = path

func getNodePath():
	return nodePath

func change_background(value):
	var r = 50.0/255
	style.bg_color = Color(r, r, r, value)
# Called when the node enters the scene tree for the first time.
func _ready():
	add_stylebox_override("panel", style)

extends Node

var x setget set_x, get_x
var y setget set_y, get_y
const color = preload("res://black.png")
var type

func init(type):
    self.type = type

func _ready():
    get_node("Sprite").texture = color
    get_node("Sprite/Label").text = type

func set_x(x):
    get_node("Sprite").position.x = 45 + (90 * x)

func get_x():
    return (get_node("Sprite").position.x - 45) / 90

func set_y(y):
    get_node("Sprite").position.y = 1260 - (40 * (y + 1))

func get_y():
    return ((1260 - get_node("Sprite").position.y) / 40) - 1

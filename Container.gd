extends Node

var x setget set_x, get_x
var items = []
var color
var type

func init(type):
    self.type = type

func _ready():
    match type:
        0: # Base
            color = load("res://blue.png")
        1: # Queue
            color = load("res://green.png")
        2: # Stack
            color = load("res://red.png")
        3: # Priority Queue
            color = load("res://yellow.png")
        4: # FIFO Ordered Set
            color = load("res://cyan.png")
        5: # LIFO Ordered Set
            color = load("res://magenta.png")
    get_node("Sprite").texture = color

func set_x(x):
    get_node("Sprite").position.x = 45 + (90 * x)

func get_x():
    return (get_node("Sprite").position.x - 45) / 90

func add(item):
    item.x = self.x
    match type:
        0, 1, 2:
            item.y = items.size()
            items.append(item)
        3:
            var pos = false
            var temp_items = []
            for i in range(items.size()):
                if pos:
                    items[i].y += 1
                elif item.type < items[i].type:
                    item.y = i
                    temp_items.append(item)
                    pos = true
                    items[i].y += 1
                temp_items.append(items[i])
            if not pos:
                item.y = items.size()
                temp_items.append(item)
            items = temp_items

func pop():
    match type:
        0, 2:
            var item = items.pop_back()
            item.y = 30
            return item
        1, 3:
            var item = items.pop_front()
            item.y = 30
            for temp_item in items:
                temp_item.y -= 1
            return item

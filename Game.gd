extends Node

signal input
signal end

var containers = []
var selection = -1
var quit = true
var base
const Container = preload("res://Container.tscn")
const Item = preload("res://Item.tscn")
var level

func init(level):
    self.level = level

func _ready():
    for i in range(level.containers.size()):
        var container = Container.instance()
        container.init(level.containers[i])
        add_child(container)
        container.x = i
        containers.append(container)
        if level.containers[i] == 0:
            base = i
    var container = Container.instance()
    container.init(0)
    add_child(container)
    container.x = 7
    for name in level.items_out:
        var item = Item.instance()
        item.init(name)
        add_child(item)
        container.add(item)

func _input(event):
    if event is InputEventScreenTouch and event.pressed:
        selection = floor(event.position.x / 90)
        selection = selection if selection < containers.size() else containers.size() - 1
        emit_signal("input")

func start():
    for name in level.items_in:
        var item = Item.instance()
        item.init(name)
        add_child(item)
        yield(self, "input")
        var container = containers[selection]
        container.add(item)
    for i in range(level.items_out.size() - containers[base].items.size()):
        var selections = []
        for i in range(containers.size()):
            if containers[i].items.size() != 0 and i != base:
                selections.append(i)
        selection = -1
        while not selection in selections:
            yield(self, "input")
        var container = containers[selection]
        var item = container.pop()
        containers[base].add(item)
    if _get_win():
        level.completed = true
        get_node("HUD/Label").text = "Level Completed!"
        get_node("HUD/Play").text = "Next Level"
    else:
        get_node("HUD/Label").text = "Try Again!"
        get_node("HUD/Play").text = "Try Again"
    _set_hud(true)
    yield(self, "end")
    _set_hud(false)
    return quit

func _get_win():
    for i in range(containers[base].items.size()):
        if containers[base].items[i].type != level.items_out[i]:
            return false
    return true

func _set_hud(state):
    get_node("HUD/Label").visible = state
    get_node("HUD/Play").visible = state
    get_node("HUD/Quit").visible = state

func _on_Play_pressed():
    quit = false
    emit_signal("end")

func _on_Quit_pressed():
    quit = true
    emit_signal("end")

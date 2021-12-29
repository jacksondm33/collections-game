extends Node

export var levels = []
const Game = preload("res://Game.tscn")

func _ready():
    pass

func _on_Play_pressed():
    _set_hud(false)
    var quit = false
    while not quit:
        var game = Game.instance()
        for level_path in levels:
            var level = get_node(level_path)
            if not level.completed:
                game.init(level)
                break
        if game.level == null:
            get_node("HUD/Play").text = "Game Completed"
            break
        add_child(game)
        var state = game.start()
        quit = yield(state, "completed")
        game.queue_free()
    _set_hud(true)

func _on_Levels_pressed():
    pass

func _set_hud(state):
    get_node("HUD/Label").visible = state
    get_node("HUD/Play").visible = state
    get_node("HUD/Levels").visible = state

extends Node

var completed = false
export var containers = []
export var items_in = []
export var items_out = []

func init(containers, items_in, items_out):
    self.containers = containers
    self.items_in = items_in
    self.items_out = items_out

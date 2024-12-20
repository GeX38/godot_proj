extends Node

func _ready():
	var level = preload("res://scenes/levels/level_1.tscn").instantiate()
	add_child(level)

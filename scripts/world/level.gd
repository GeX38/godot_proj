extends Node2D

@onready var tile_map = $TileMap

const TILE_ID_SPIKE = 2

func _ready():
	print("gun")

func _on_death_zone_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		body.die() 

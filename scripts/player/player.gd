extends CharacterBody2D

# Константы
const SPEED = 200
const JUMP_FORCE = -400
const GRAVITY = 800
const TILE_ID_SPIKE = 2

@onready var animated_sprite = $AnimatedSprite2D
@onready var tile_map = get_parent()

# Обработчик смерти
func die():
	print("Player has died!")
	#position = Vector2(64, 64)  # Возврат на стартовую позицию (или перезагрузка уровня)
	#velocity = Vector2.ZERO
	get_tree().reload_current_scene()



func _physics_process(delta):
	# Гравитация
	velocity.y += GRAVITY * delta

	velocity.x = 0
	if Input.is_action_pressed("move_right"):
		velocity.x += SPEED
		animated_sprite.flip_h = false
	elif Input.is_action_pressed("move_left"):
		velocity.x -= SPEED
		animated_sprite.flip_h = true

	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_FORCE

	move_and_slide()

	if not is_on_floor():
		animated_sprite.play("Jump")
	elif velocity.x != 0:
		animated_sprite.play("Run")
	else:
		animated_sprite.play("Idle")

	check_for_spikes()

		
func check_for_spikes():
	# Получаем координаты игрока в пространстве TileMap и ID тайла на позиции
	var tile_position = tile_map.local_to_map(global_position)

	var tile_id = tile_map.get_cell_source_id(0, tile_position)
	
	if tile_id == TILE_ID_SPIKE:
		die()

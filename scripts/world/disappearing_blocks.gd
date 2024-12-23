extends TileMap

# Константы
const TILE_ID_DISAPPEAR = 3  # ID исчезающих блоков
const DISAPPEAR_DELAY = 3.0  # Задержка в секундах перед исчезновением

# Таймеры для управления блоками
var disappearing_blocks = []

func _ready():
	# Вызываем проверку каждые 0.1 секунды
	set_process(true)

func _process(delta):
	# Массив для хранения индексов блоков, которые нужно удалить
	var to_remove = []
	
	# Обновляем таймеры блоков
	for i in range(disappearing_blocks.size()):
		var block = disappearing_blocks[i]
		block.time -= delta
		if block.time <= 0:
			# Убираем тайл, когда время истекло
			set_cell(0, block.position, -1)  # Убираем тайл с карты
			to_remove.append(i)  # Добавляем индекс на удаление
	
	# Удаляем блоки после завершения цикла
	for index in range(to_remove.size() - 1, -1, -1):  # Итерация в обратном порядке
		disappearing_blocks.remove_at(to_remove[index])

func trigger_disappearing_block(position: Vector2i):
	# Добавляем блок в очередь на исчезновение
	disappearing_blocks.append({
		"position": position,
		"time": DISAPPEAR_DELAY
	})

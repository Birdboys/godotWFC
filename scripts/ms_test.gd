extends Node2D

var dim = Vector2(10, 10)
var ms : ModelSynthesizer
var sprite_grid := {}
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var current_time = Time.get_ticks_msec()
	initSprites()
	initGridLines()
	$Camera2D.position = dim*64/2 + Vector2.UP * 32
	ms = ModelSynthesizer.new()
	ms.getInfo()
	ms.initModelSynthesis(dim)
	#var ms_grid = ms.doWaveFunctionCollapse()
	#updateSprites(ms_grid)
	#var elapsed_time = (Time.get_ticks_msec()-current_time)/1000.0
	#print("TIME ELAPSED:",elapsed_time)

func _input(event: InputEvent) -> void:
	if Input.is_action_pressed("space"):
		var ms_grid = ms.doOneRound()
		updateSprites(ms_grid)
		
func initSprites():
	for x in range(dim.x):
		for y in range(dim.y):
			var new_sprite = Sprite2D.new()
			add_child(new_sprite)
			new_sprite.position = Vector2(x, y) * 64
			sprite_grid[Vector2(x, y)] = new_sprite

func initGridLines():
	for x in range(dim.x):
		var new_line := Line2D.new()
		add_child(new_line)
		new_line.default_color = Color.GREEN
		new_line.width = 4
		new_line.points = [Vector2(x, 0)*64, Vector2(x, dim.y)*64]
		new_line.points = Array(new_line.points).map(func(p): return p-Vector2(32,32))
	for y in range(dim.y):
		var new_line := Line2D.new()
		add_child(new_line)
		new_line.default_color = Color.GREEN
		new_line.width = 4
		new_line.points = [Vector2(0, y)*64, Vector2(dim.x, y)*64]
		new_line.points = Array(new_line.points).map(func(p): return p-Vector2(32,32))
		
func updateSprites(grid):
	for c in grid:
		if grid[c].is_collapsed: sprite_grid[c].texture = getTexture(grid[c].tile_type)
		else: sprite_grid[c].texture = getTexture(-1)
		sprite_grid[c].rotation = PI/2.0 * grid[c].rot_val
		
func getTexture(id):
	match id:
		WFCInfo.tile_type.GRASS: return load("res://assets/grass_tile.png")
		WFCInfo.tile_type.ROAD_L: return load("res://assets/road_l_tile.png")
		WFCInfo.tile_type.ROAD_X: return load("res://assets/road_x_tile.png")
		WFCInfo.tile_type.ROAD_E: return load("res://assets/road_e_tile.png")
		WFCInfo.tile_type.ROAD_R: return load("res://assets/road_r_tile.png")
		WFCInfo.tile_type.ROAD_T: return load("res://assets/road_t_tile.png")
		#WFCInfo.tile_type.GRASS_R: return load("res://assets/grass_r_tile.png")
		#WFCInfo.tile_type.GRASS_L: return load("res://assets/grass_l_tile.png")
		_: return load("res://assets/blank_tile.png")

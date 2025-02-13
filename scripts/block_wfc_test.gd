extends Node2D

var blockWFC : BlockWFC
var block_dim := Vector2(7,7)
var block_overlap := 1
var sprite_grid := {}

func _ready() -> void:
	blockWFC = BlockWFC.new()
	blockWFC.initBlockWFC(block_dim, block_overlap)
	for x in blockWFC.tile_grid:
		addSprite(x)
	updateSprites()

func _process(delta: float) -> void:
	$Camera2D.position = $Camera2D.position.move_toward(get_global_mouse_position(), 250.0*delta)
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("left"):
		blockWFC.moveCurrentPosition(Vector2.LEFT)
		updateSprites()
	if event.is_action_pressed("right"):
		blockWFC.moveCurrentPosition(Vector2.RIGHT)
		updateSprites()
	if event.is_action_pressed("up"):
		blockWFC.moveCurrentPosition(Vector2.UP)
		updateSprites()
	if event.is_action_pressed("down"):
		blockWFC.moveCurrentPosition(Vector2.DOWN)
		updateSprites()

func addSprite(coord):
	var new_sprite = Sprite2D.new()
	add_child(new_sprite)
	sprite_grid[coord] = new_sprite
	new_sprite.texture = load("res://assets/road_x_tile.png")
	new_sprite.position = Vector2(64,64) * coord
	
func updateSprites():
	for b in blockWFC.blocks:
		var block = blockWFC.getBlock(b)
		for t in block:
			if t not in sprite_grid: addSprite(t)
			sprite_grid[t].texture = getTexture(blockWFC.tile_grid[t].tile_type)
			sprite_grid[t].rotation = PI/2 * blockWFC.tile_grid[t].rot_val

func getTexture(id):
	match id:
		WFCInfo.tile_type.GRASS: return load("res://assets/grass_tile.png")
		WFCInfo.tile_type.ROAD_L: return load("res://assets/road_l_tile.png")
		WFCInfo.tile_type.ROAD_X: return load("res://assets/road_x_tile.png")
		WFCInfo.tile_type.ROAD_E: return load("res://assets/road_e_tile.png")
		WFCInfo.tile_type.ROAD_R: return load("res://assets/road_r_tile.png")
		WFCInfo.tile_type.ROAD_T: return load("res://assets/road_t_tile.png")
		WFCInfo.tile_type.LAKE: return load("res://assets/lake_tile.png")
		#WFCInfo.tile_type.HOUSE_LF: return load("res://assets/house_lf_tile.png")
		_: return load("res://assets/blank_tile.png")

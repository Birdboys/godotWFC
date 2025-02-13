extends Node
class_name WFCInfo

enum tile_type {GRASS, ROAD_L, ROAD_X, ROAD_E, ROAD_T, ROAD_R, LAKE}
enum connector_type {SIDEWALK, ROAD, GRASS}

const tile_weights := {tile_type.GRASS:5.0, tile_type.LAKE:2.0}
const dir_to_num := {Vector2.UP:0,Vector2.RIGHT:1,Vector2.DOWN:2,Vector2.LEFT:3}

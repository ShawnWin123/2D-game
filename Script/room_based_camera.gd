extends Camera2D

@onready var screenSize : Vector2 = get_viewport_rect().size
@onready var playerNode: CharacterBody2D = $"../Player"


func _ready():
	set_screen_position()
	await get_tree().process_frame
	position_smoothing_enabled = true
	position_smoothing_speed = 10
	
func _process(delta: float) -> void:
	screenSize = get_viewport_rect().size
	set_screen_position()
	
func set_screen_position():
	var playerPos = playerNode.global_position
	var x = floor(playerPos.x / screenSize.x) * screenSize.x + screenSize.x/2
	var y = floor(playerPos.y / screenSize.y) * screenSize.y + screenSize.y/2
	global_position = Vector2(x,y)

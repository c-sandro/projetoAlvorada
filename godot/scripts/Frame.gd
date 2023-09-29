extends Control

var screenSize = Vector2.ZERO

func _process(_delta):
	screenSize = get_viewport_rect().size
	$RightRect.set_size(Vector2(16, screenSize.y))
	$LeftRect.set_size(Vector2(390, screenSize.y))
	$UpRect.set_size(Vector2(screenSize.x, 16))
	$RightRect.set_size(Vector2(screenSize.x, 16))
	

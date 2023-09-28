extends CanvasLayer

var sunTime: float = 0
@export var sunTimeRequired: int = 1

var isMouseInSun: bool = false

func _process(delta):
	if(isMouseInSun):
		sunTime += delta
		if(sunTime >= sunTimeRequired):
			updateSunAmount(1)
			sunTime = 0
		
func updateSunAmount(sunAmount):
	$SunCount.text = str(sunAmount + int($SunCount.text))

func _on_sun_mouse_entered():
	isMouseInSun = true

func _on_sun_mouse_exited():
	isMouseInSun = false
	sunTime = 0

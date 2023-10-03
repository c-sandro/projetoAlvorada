extends Control

var isMouseInSun: bool = false
var sunTimer

func _ready():
	sunTimer = get_node("../../SunEnergyManager/SunTimer")

func _process(_delta):
	
	if(!isMouseInSun):
		return
	
	var timeLeft: float = sunTimer.get_time_left()
	var totalTime: float = sunTimer.get_wait_time()
	
	set_position(Vector2(get_global_mouse_position().x - 40, get_global_mouse_position().y))
	$HowFull.set_size(Vector2(24, 96 * ((totalTime - timeLeft) / totalTime)))
	

func _on_sun_mouse_entered():
	self.visible = true
	isMouseInSun = true

func _on_sun_mouse_exited():
	self.visible = false
	isMouseInSun = false

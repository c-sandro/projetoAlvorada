extends Control

var isMouseInSun: bool = false

func _process(delta):
	
	if(!isMouseInSun):
		return
	
	set_position(Vector2(get_global_mouse_position().x - 40, get_global_mouse_position().y))
	


func _on_sun_mouse_entered():
	self.visible = true
	isMouseInSun = true

func _on_sun_mouse_exited():
	self.visible = false
	isMouseInSun = false

func _on_sun_energy_manager_sun_time(totalTime, time):
	$HowFull.set_size(Vector2($HowFull.size.x, $HowFull.size.y * (time / totalTime)))

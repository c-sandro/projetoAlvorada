extends Node

var sunTime: float = 0
@export var sunTimeRequired: int = 1

var isMouseInSun: bool = false

var sunTotal: int = 0
var sunGainedPerTick: int = 1

func increaseSunAmount():
	sunTotal += sunGainedPerTick

func _process(delta):
	if(isMouseInSun):
		sunTime += delta
		if(sunTime >= sunTimeRequired):
			increaseSunAmount()
			sunTime = 0

func _on_sun_mouse_entered():
	isMouseInSun = true

func _on_sun_mouse_exited():
	isMouseInSun = false
	sunTime = 0

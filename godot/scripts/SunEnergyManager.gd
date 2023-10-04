extends Node

@export var sunTotal: int = 0
var sunGainedPerTick: int = 1
var mouseCost: int = 10
var mouseUpgrades: int = 0

signal sunTick
signal mouseBought
signal buildingBought

func completeSunTick():
	sunTotal += sunGainedPerTick
	changeSunCountHUD()
	
#funções pra mudar os valores na hud
func changeSunCountHUD():
	sunTick.emit(sunTotal)
	
func changeMousePriceHUD():
	mouseBought.emit(mouseCost, sunGainedPerTick)
	
func changeBuildingPriceHUD(building, newPrice):
	buildingBought.emit(building, newPrice)

#funções pra começar e parar o timer do sol
func _on_sun_mouse_entered():
	$SunTimer.start()

func _on_sun_mouse_exited():
	$SunTimer.stop()

#funções de upgrade
func _on_mouse_upgrade_button_down():
	if(sunTotal < mouseCost):
		return
	
	mouseUpgrades += 1
	sunTotal -= mouseCost
	sunGainedPerTick += 1
	mouseCost = roundi(10 * (1.15 ** mouseUpgrades))
	changeSunCountHUD()
	changeMousePriceHUD()

#funções de timer
func _on_sun_timer_timeout():
	completeSunTick()

func _on_buildings_manager_building_tick(value):
	sunTotal += value
	changeSunCountHUD()

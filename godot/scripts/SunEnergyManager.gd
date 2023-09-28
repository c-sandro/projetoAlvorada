extends Node

var sunTime: float = 0
@export var sunTimeRequired: int = 1

var isMouseInSun: bool = false

var sunTotal: int = 0
var sunGainedPerTick: int = 1

var upgradesCosts: Array = [10,50]
var buildings: Array = [0]

signal sunTick
signal upgradeBought

func completeSunTick():
	sunTotal += sunGainedPerTick
	sunTime = 0
	changeSunCountHUD()
	
func changeSunCountHUD():
	sunTick.emit(sunTotal)
	
func changeUpgradePriceHUD(upgrade, newPrice):
	upgradeBought.emit(upgrade, newPrice)

func _process(delta):
	
	if(isMouseInSun):
		sunTime += delta
		if(sunTime >= sunTimeRequired):
			completeSunTick()
	

func _on_sun_mouse_entered():
	isMouseInSun = true

func _on_sun_mouse_exited():
	isMouseInSun = false
	sunTime = 0

func _on_hud_mouse_upgrade_pressed():
	if(sunTotal >= upgradesCosts[0]):
		sunTotal -= upgradesCosts[0]
		sunGainedPerTick += 1
		upgradesCosts[0] = roundi(upgradesCosts[0] * 1.5)
		changeSunCountHUD()
		changeUpgradePriceHUD(0, upgradesCosts[0])


func _on_hud_building_buy_pressed():
	
	if(sunTotal >= upgradesCosts[1]):
		sunTotal -= upgradesCosts[1]
		buildings[0] += 1
		upgradesCosts[1] = roundi(upgradesCosts[1] * 1.5)
		changeSunCountHUD()
		changeUpgradePriceHUD(1, upgradesCosts[1])
		if(buildings[0] == 1):
			$BuildingTimer.start()


func _on_building_timer_timeout():
	sunTotal += 1
	changeSunCountHUD()

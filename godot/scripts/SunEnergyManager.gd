extends Node

@export var sunTotal: int = 0
var sunGainedPerTick: int = 1
var mouseCost: int = 10

var buildings: Array = [Timer]

signal sunTick
signal sunTime
signal mouseBought
signal buildingBought

func _ready():
	
	buildings[0] = $WindPowerTimer
	buildings[0].startBuilding(25,1,10)
	

func _process(_delta):
	sunTime.emit($SunTimer.wait_time, $SunTimer.wait_time - $SunTimer.time_left)

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
	
	sunTotal -= mouseCost
	sunGainedPerTick += 1
	mouseCost = roundi(mouseCost * 1.5)
	changeSunCountHUD()
	changeMousePriceHUD()

func _on_wind_power_buy_button_down():
	if(sunTotal < buildings[0].cost):
		return
	
	sunTotal -= buildings[0].cost
	buildings[0].quantity += 1
	buildings[0].cost = roundi(buildings[0].cost * 1.5)
	
	changeSunCountHUD()
	
	buildings[0].defineSunPerSecond()
	
	changeBuildingPriceHUD(0, buildings[0].cost)
	
	if(buildings[0].quantity == 1):
		buildings[0].start()
	
#funções de timer
func _on_sun_timer_timeout():
	completeSunTick()

func _on_wind_power_timer_timeout():
	sunTotal += buildings[0].quantity
	changeSunCountHUD()

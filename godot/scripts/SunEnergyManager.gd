extends Node

@export var sunTotal: int = 0
var sunGainedPerTick: int = 1
var mouseCost: int = 10
var sunPerSecond: float = 0

var Building = load("res://Building.tscn")

var buildings: Array = [Timer]

signal sunTick
signal mouseBought
signal buildingBought

func _ready():
	
	buildings[0] = Building.instantiate()
	buildings[0].startBuilding(25,1,10)
	
	

func completeSunTick():
	sunTotal += sunGainedPerTick
	changeSunCountHUD()
	
#funções pra mudar os valores na hud
func changeSunCountHUD():
	sunTick.emit(sunTotal)
	
func changeMousePriceHUD():
	mouseBought.emit(mouseCost, sunGainedPerTick)
	
func changeBuildingPriceHUD(building, newPrice):
	buildingBought.emit(building, newPrice, sunPerSecond)

#funções pra começar e parar o timer do sol
func _on_sun_mouse_entered():
	$SunTimer.start()

func _on_sun_mouse_exited():
	$SunTimer.stop()

#funções de upgrade
func _on_hud_mouse_upgrade_pressed():
	
	if(sunTotal < mouseCost):
		return
	
	sunTotal -= mouseCost
	sunGainedPerTick += 1
	mouseCost = roundi(mouseCost * 1.5)
	changeSunCountHUD()
	changeMousePriceHUD()

func _on_hud_building_buy_pressed(index):
	
	if(sunTotal < buildings[index].cost):
		return
	
	sunTotal -= buildings[index].cost
	buildings[index].quantity += 1
	buildings[index].cost = roundi(buildings[index].cost * 1.5)
	
	changeSunCountHUD()
	
	buildings[index].defineSunPerSecond()
	
	sunPerSecond = 0
	for i in buildings:
		sunPerSecond += i.sunPerSecond
		
	changeBuildingPriceHUD(index, buildings[index].cost)
	
	if(buildings[index].quantity == 1):
		buildings[index].start()
	


func _on_sun_timer_timeout():
	completeSunTick()

func _on_building_building_tick():
	sunTotal += buildings[0].quantity
	changeSunCountHUD()

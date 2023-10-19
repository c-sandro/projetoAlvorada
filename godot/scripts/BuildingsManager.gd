extends Control

var buildings: Array = [Timer]
@export var sunEnergyManager: Node

signal buildingTick

func _ready():
	
	buildings[0] = $WindPower/WindPowerTimer
	buildings[0].startBuilding(25,1,10)

func completeBuildingTimer(value):
	buildingTick.emit(value)

#funções da usina eólica
func _on_wind_power_buy_button_down():
	if(sunEnergyManager.sunTotal < buildings[0].cost):
		return
	
	sunEnergyManager.sunTotal -= buildings[0].cost
	buildings[0].quantity += 1
	buildings[0].cost = roundi(buildings[0].basePrice * (1.15 ** buildings[0].quantity))
	
	sunEnergyManager.changeSunCountHUD()

	sunEnergyManager.changeBuildingPriceHUD(0, buildings[0].cost)
	
	if(buildings[0].quantity == 1):
		buildings[0].start()
		$WindPower/WindPowerPlant.visible = true
		$WindPower/WindPowerPlant.startBuilding()
	else:
		buildings[0].checkMark()
	
	$WindPower/WindPowerPlant.updateBuilding(buildings[0].sunGained,
								$WindPower/WindPowerTimer.wait_time,
											  buildings[0].quantity)

func _on_wind_power_timer_timeout():
	completeBuildingTimer(buildings[0].sunGained * buildings[0].quantity)
	

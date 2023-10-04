extends Control

@export var buildings: Array = [Timer]
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
	buildings[0].cost = roundi(buildings[0].basePrice )#* (1.15 ** buildings[0].quantity))
	
	sunEnergyManager.changeSunCountHUD()

	sunEnergyManager.changeBuildingPriceHUD(0, buildings[0].cost)
	
	if(buildings[0].quantity == 1):
		buildings[0].start()
		$WindPower/WindPowerPlant.visible = true
		$WindPower/WindPowerPlant.startBuilding()
	elif(buildings[0].quantity == 10):
		buildings[0].buildingMark1()
	elif(buildings[0].quantity == 25):
		buildings[0].buildingMark2()
	elif(buildings[0].quantity == 50):
		buildings[0].buildingMark3()
	elif(buildings[0].quantity == 100):
		buildings[0].buildingMark4()
	
	$WindPower/WindPowerPlant.updateBuilding(buildings[0].sunGained,
								$WindPower/WindPowerTimer.wait_time,
											  buildings[0].quantity)

func _on_wind_power_timer_timeout():
	completeBuildingTimer(buildings[0].sunGained * buildings[0].quantity)
	

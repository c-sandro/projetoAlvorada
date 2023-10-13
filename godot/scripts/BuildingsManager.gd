extends Control

@export var buildings: Array = [Timer, Timer, Timer]
@export var sunEnergyManager: Node

signal buildingTick

func _ready():
	
	buildings[0] = $WindPower/WindPowerTimer
	buildings[0].startBuilding(25,1,10)
	buildings[1] = $WaterPower/WaterPowerTimer
	buildings[1].startBuilding(100,5,20)
	buildings[2] = $NuclearPower/NuclearPowerTimer
	buildings[2].startBuilding(250,10,15)

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


func _on_water_power_buy_button_down():
	if(sunEnergyManager.sunTotal < buildings[1].cost):
		return
	
	sunEnergyManager.sunTotal -= buildings[1].cost
	buildings[1].quantity += 1
	buildings[1].cost = roundi(buildings[1].basePrice * (1.15 ** buildings[1].quantity))
	
	sunEnergyManager.changeSunCountHUD()

	sunEnergyManager.changeBuildingPriceHUD(1, buildings[1].cost)
	
	if(buildings[1].quantity == 1):
		buildings[1].start()
		$WaterPower/WaterPowerPlant.visible = true
		$WaterPower/WaterPowerPlant.startBuilding()
	elif(buildings[1].quantity == 10):
		buildings[1].buildingMark1()
	elif(buildings[1].quantity == 25):
		buildings[1].buildingMark2()
	elif(buildings[1].quantity == 50):
		buildings[1].buildingMark3()
	elif(buildings[1].quantity == 100):
		buildings[1].buildingMark4()
	
	$WaterPower/WaterPowerPlant.updateBuilding(buildings[1].sunGained,
								$WaterPower/WaterPowerTimer.wait_time,
											  buildings[1].quantity)

func _on_water_power_timer_timeout():
	completeBuildingTimer(buildings[1].sunGained * buildings[1].quantity)

func _on_nuclear_power_buy_button_down():
	if(sunEnergyManager.sunTotal < buildings[2].cost):
		return
	
	sunEnergyManager.sunTotal -= buildings[2].cost
	buildings[2].quantity += 2
	buildings[2].cost = roundi(buildings[2].basePrice * (1.15 ** buildings[2].quantity))
	
	sunEnergyManager.changeSunCountHUD()

	sunEnergyManager.changeBuildingPriceHUD(2, buildings[2].cost)
	
	if(buildings[2].quantity == 2):
		buildings[2].start()
		$NuclearPower/NuclearPowerPlant.visible = true
		$NuclearPower/NuclearPowerPlant.startBuilding()
	elif(buildings[2].quantity == 10):
		buildings[2].buildingMark2()
	elif(buildings[2].quantity == 25):
		buildings[2].buildingMark2()
	elif(buildings[2].quantity == 50):
		buildings[2].buildingMark3()
	elif(buildings[2].quantity == 100):
		buildings[2].buildingMark4()
	
	$NuclearPower/NuclearPowerPlant.updateBuilding(buildings[2].sunGained,
								$NuclearPower/NuclearPowerTimer.wait_time,
											  buildings[2].quantity)

func _on_nuclear_power_timer_timeout():
	completeBuildingTimer(buildings[2].sunGained * buildings[2].quantity)


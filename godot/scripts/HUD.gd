extends Control

#funções de abrir e fechar o menu
func _on_open_menu_button_down():
	$Menu.visible = true
	$Buttons.visible = true
	$OpenMenu.visible = false

func _on_close_menu_button_down():
	$Menu.visible = false
	$Buttons.visible = false
	$OpenMenu.visible = true

#funções de mudar o valor da hud
func _on_sun_energy_manager_sun_tick(newSunAmount):
	$SunCount.text = str(newSunAmount)

func _on_sun_energy_manager_mouse_bought(newPrice, newSPT):
	$Buttons/MouseUpgrade/Price.text = str(newPrice)
	$Menu/SunPerTick.text = str(newSPT)

func _on_sun_energy_manager_building_bought(building, newPrice):
	if(building == 0):
		$Buttons/WindPowerBuy/Price.text = str(newPrice)
	elif(building == 1):
		$Buttons/WaterPowerBuy/Price.text = str(newPrice)
	elif(building == 2):
		$Buttons/NuclearPowerBuy/Price.text = str(newPrice)

func _on_sun_time_elapsed(dayTime):
	$Time.text = str(dayTime) + ":00"

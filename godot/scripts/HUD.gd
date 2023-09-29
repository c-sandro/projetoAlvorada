extends CanvasLayer

signal mouseUpgradePressed
signal buildingBuyPressed

#funções de melhoria do mouse
func _on_mouse_upgrade_button_down():
	mouseUpgradePressed.emit()

#funções de compra da construção
func _on_building_buy_button_down():
	buildingBuyPressed.emit(0)

#funções de abrir e fechar o menu
func _on_open_menu_button_down():
	$Menu.visible = true
	$OpenMenu.visible = false

func _on_close_menu_button_down():
	$Menu.visible = false
	$OpenMenu.visible = true

#funções de mudar o valor da hud
func _on_sun_energy_manager_sun_tick(newSunAmount):
	$SunCount.text = str(newSunAmount)

func _on_sun_energy_manager_mouse_bought(newPrice, newSPT):
	$Menu/MouseUpgrade/Price.text = str(newPrice)
	$SunPerTick.text = str(newSPT)

func _on_sun_energy_manager_building_bought(upgrade, newPrice, newSPS):
	if(upgrade == 0):
		$Menu/BuildingBuy/Price.text = str(newPrice)
	$SunPerSecond.text = str(newSPS)
	

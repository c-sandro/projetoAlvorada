extends CanvasLayer

signal mouseUpgradePressed
signal buildingBuyPressed

func _on_sun_energy_manager_sun_tick(newSunAmount):
	$SunCount.text = str(newSunAmount)

#funções de melhoria do ganho de sol do mouse
func _on_mouse_upgrade_button_down():
	mouseUpgradePressed.emit()

func _on_sun_energy_manager_upgrade_bought(upgrade, newPrice):
	if(upgrade == 0):
		$Menu/MouseUpgrade/Price.text = str(newPrice)
	elif(upgrade == 1):
		$Menu/BuildingBuy/Price.text = str(newPrice)

#funções de compra da construção
func _on_building_buy_button_down():
	buildingBuyPressed.emit()


#funções de abrir e fechar o menu
func _on_open_menu_button_down():
	$Menu.visible = true
	$OpenMenu.visible = false

func _on_close_menu_button_down():
	$Menu.visible = false
	$OpenMenu.visible = true


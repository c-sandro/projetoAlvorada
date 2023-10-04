class_name Building extends Timer

var cost: int = 0
var quantity: int = 0
var sunGained: int = 0
var basePrice: int = 0

func startBuilding(newCost, newSunGained, newTickTime):
	basePrice = newCost
	cost = newCost
	sunGained = newSunGained
	self.wait_time = newTickTime

func buildingMark1():
	self.wait_time /= 2

func buildingMark2():
	sunGained *= 2

func buildingMark3():
	self.wait_time /= 2

func buildingMark4():
	sunGained *= 2

class_name Building extends Timer

var cost: int = 0
var quantity: int = 0
var sunGained: int = 0

func startBuilding(newCost, newSunGained, newTickTime):
	cost = newCost
	sunGained = newSunGained
	self.wait_time = newTickTime

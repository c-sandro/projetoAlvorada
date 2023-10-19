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

func checkMark():
	if(quantity == 10):
		self.wait_time /= 2
	elif(quantity == 25):
		sunGained *= 2
	elif(quantity == 50):
		self.wait_time /= 2
	elif(quantity == 100):
		sunGained *= 2

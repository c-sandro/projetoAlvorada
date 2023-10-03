extends ColorRect

@export var buildingTimer: Timer

func startBuilding():
	$ProgressBar.visible = true
	
func updateBuilding(newGain, newTime, newQuantity):
	$InfoWindow/Text/GainPerTick.text = str(newGain)
	$InfoWindow/Text/TickTime.text = str(newTime)
	$InfoWindow/Text/Quantity.text = str(newQuantity)
	
func _process(_delta):

	var timeLeft: float = buildingTimer.get_time_left()
	var totalTime: float = buildingTimer.get_wait_time()
	
	$ProgressBar/HowFull.set_size(Vector2(24, 96 * ((totalTime - timeLeft) / totalTime)))


func _on_mouse_entered():
	$InfoWindow.visible = true

func _on_mouse_exited():
	$InfoWindow.visible = false

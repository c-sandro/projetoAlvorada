extends CharacterBody2D

@export var sunSpeed: int = 100
var screenSize = Vector2.ZERO

func _ready():
	#deixa o sol "clicavel"
	input_pickable = true
	
	#setup do movimento do sol
	const directionAngles: Array = [PI/4, 3*PI/4, 5*PI/4, 7*PI/4]
	var direction: Vector2 = Vector2(sunSpeed, 0).rotated(directionAngles[randi_range(0,3)])
	velocity = direction.move_toward(direction, sunSpeed)
	
	screenSize = get_viewport_rect().size
	
func _process(delta):
	
	#método pra fazer o sol quicar nas bordas
	if(position.x >= screenSize.x || position.x <= 0):
		velocity.x = -velocity.x
	elif(position.y >= screenSize.y || position.y <= 0):
		velocity.y = -velocity.y
		
	#função pro sol mover
	move_and_slide()

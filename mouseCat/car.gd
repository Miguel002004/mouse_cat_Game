extends CharacterBody2D

@export var speed = 400
@export var jump_force = -500  # Ajusta según sea necesario
var gravity = 10980  # Gravedad, ajusta según sea necesario
var falling_speed = 4000  # Velocidad de caída
var max_falling_speed = 8000  # Velocidad máxima de caída, ajusta según sea necesario
var on_floor = false
@onready var sprite = $Sprite2D
@onready var viewport_rect = get_viewport().get_visible_rect()
@onready var tamanio = sprite.texture.get_height()
var tmp_yposition = 0
var jumping = false

func _physics_process(delta):
	#print(position.y)
	#print(jumping)
	var input_direction = Vector2.ZERO
	input_direction.y += (gravity * delta) * 2
	if Input.is_action_pressed('ui_left'):
		input_direction.x -= 4**3  * delta
		sprite.flip_h = true  # Hace que el personaje mire a la izquierda
	if Input.is_action_pressed('ui_right'):
		input_direction.x += 4**3  * delta
		sprite.flip_h = false # Hace que el personaje mire a la derecha

	input_direction.x *= speed

	# Salto
	if Input.is_action_just_pressed("ui_select") and is_on_floor():
		jumping = true
		tmp_yposition = position.y
	
	if jumping: 
		input_direction = jump(input_direction)
	
	#input_direction.y += falling_speed * delta  # Añade la velocidad de caída a la dirección de entrada
	self.velocity = input_direction
	
	colisionPantalla()
	move_and_slide()
	
func colisionPantalla():
	if position.x < viewport_rect.position.x:
		position.x = viewport_rect.position.x
	if position.x > viewport_rect.end.x:
		position.x = viewport_rect.end.x
	if position.y < viewport_rect.position.y:
		position.y = viewport_rect.position.y
	if position.y > viewport_rect.end.y:
		position.y = viewport_rect.end.y
		
func jump(input_direction: Vector2) -> Vector2:
	print("posicion actual: " + str(position.y))
	#print(tamanio)
	print("posición temporal: " + str(tmp_yposition))
	#input_direction.y += jump_force
	if jumping:
		input_direction.y += -600
	#	print("saltando")
	print("posicion final: " + str((tmp_yposition+(tamanio)*2) + - 600))
	#if position.y >= ((tmp_yposition - tamanio) + - 600):
	#	jumping = false
	#get_tree().quit()
	return input_direction
	#get_tree().quit()


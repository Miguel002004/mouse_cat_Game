extends CharacterBody2D

@export var speed = 400
@export var jump_force = -500  # Ajusta según sea necesario
var gravity = 10980  # Gravedad, ajusta según sea necesario
@onready var sprite = $Sprite2D
@onready var viewport_rect = get_viewport().get_visible_rect()

func _physics_process(delta):
	velocity = Vector2.ZERO
	
	# Movimiento horizontal
	if Input.is_action_pressed('ui_left'):
		velocity.x = -speed
		sprite.flip_h = true
	elif Input.is_action_pressed('ui_right'):
		velocity.x = speed
		sprite.flip_h = false
	
	# Gravedad
	velocity.y += gravity * delta

	# Salto
	if Input.is_action_just_pressed('ui_select') and is_on_floor():
		velocity.y = jump_force
	
	# Límite de velocidad de caída
	velocity.y = min(velocity.y, gravity)

	# Movimiento y colisión
	move_and_slide()  # Aquí está la corrección principal

	# Restricciones de pantalla
	position.x = clamp(position.x, viewport_rect.position.x, viewport_rect.end.x)
	position.y = clamp(position.y, viewport_rect.position.y, viewport_rect.end.y)

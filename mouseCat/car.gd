extends CharacterBody2D

@export var speed := 180
var direccion := 0.0  # Ajusta según sea necesario
var jump := 350  # Gravedad, ajusta según sea necesario
const gravity := 10
@onready var sprite = $Sprite2D
@onready var viewport_rect = get_viewport().get_visible_rect()

func _physics_process(delta):
	direccion = Input.get_axis("ui_left", "ui_right")
	velocity.x = direccion * speed
	if Input.is_action_pressed('ui_left'):
		sprite.flip_h = true
	if Input.is_action_pressed('ui_right'):
		sprite.flip_h = false
	if is_on_floor() and Input.is_action_just_pressed("ui_accept"):
		velocity.y -= jump
	velocity.y += gravity
	# Movimiento y colisión
	move_and_slide()  # Aquí está la corrección principal

	# Restricciones de pantalla
	position.x = clamp(position.x, viewport_rect.position.x, viewport_rect.end.x)
	position.y = clamp(position.y, viewport_rect.position.y, viewport_rect.end.y)

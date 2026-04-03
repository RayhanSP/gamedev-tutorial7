extends CharacterBody3D

@export var speed: float = 2.0 
@export var acceleration: float = 3.0 
@export var friction: float = 30.0 
@export var gravity: float = 9.8
@export var jump_power: float = 2.0
@export var mouse_sensitivity: float = 0.3
var collected_cups: int = 0

@onready var head: Node3D = $Head
@onready var camera: Camera3D = $Head/Camera3D
@onready var coffee_label: Label = $HUD/CoffeeCounter

var camera_x_rotation: float = 0.0

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	

func _input(event):
	if Input.is_action_just_pressed("ui_cancel"):
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	if event is InputEventMouseMotion and Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
		head.rotate_y(deg_to_rad(-event.relative.x * mouse_sensitivity))
		var x_delta = event.relative.y * mouse_sensitivity
		camera_x_rotation = clamp(camera_x_rotation - x_delta, -90.0, 90.0)
		camera.rotation_degrees.x = camera_x_rotation

func _physics_process(delta):
	var movement_vector = Vector3.ZERO
	
	if Input.is_action_pressed("movement_forward"):
		movement_vector -= head.basis.z
	if Input.is_action_pressed("movement_backward"):
		movement_vector += head.basis.z
	if Input.is_action_pressed("movement_left"):
		movement_vector -= head.basis.x
	if Input.is_action_pressed("movement_right"):
		movement_vector += head.basis.x
		
	movement_vector = movement_vector.normalized()
	
	if movement_vector != Vector3.ZERO:
		velocity.x = lerp(velocity.x, movement_vector.x * speed, acceleration * delta)
		velocity.z = lerp(velocity.z, movement_vector.z * speed, acceleration * delta)
	else:
		velocity.x = lerp(velocity.x, 0.0, friction * delta)
		velocity.z = lerp(velocity.z, 0.0, friction * delta)
	
	if not is_on_floor():
		velocity.y -= gravity * delta
		
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = jump_power
		
	move_and_slide()

func collect_item():
	collected_cups += 1
	coffee_label.text = "Kopi: " + str(collected_cups) + " / 4"
	print("Kopi terkumpul: ", collected_cups)

extends CharacterBody3D

@export_group("Camera")
@export_range(0.0, 1.0) var mouse_sensitivity := 0.25

@export_group("Movement")
@export var move_speed := 3.0
@export var acceleration := 20.0 
@export var rotation_speed := 1
@export var jump_impulse = 12.0

var _camera_input_direction := Vector2.ZERO
var _last_movement_direction := Vector3.BACK
var _gravity = -30.0
var is_attacking = false

@onready var _camera_pivot: Node3D = %CameraPivot
@onready var _camera: Camera3D = %Camera3D
#@onready var _skin: Node3D = %GroundsKeeper

func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("release_mouse"):
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE

func _unhandled_input(event: InputEvent) -> void:
	var is_camera_motion := (
		event is InputEventMouseMotion and
		Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED
	)
	if is_camera_motion:
		_camera_input_direction = event.screen_relative * mouse_sensitivity

func set_attacking_false():
	is_attacking = false

func _physics_process(delta: float) -> void:
	_camera_pivot.rotation.x += _camera_input_direction.y * delta
	_camera_pivot.rotation.x = clamp(_camera_pivot.rotation.x, -PI / 6.0, PI / 3.0)
	_camera_pivot.rotation.y -= _camera_input_direction.x * delta
	
	_camera_input_direction = Vector2.ZERO

	var raw_input := Input.get_vector("move_left", "move_right", "move_forward", "move_back")
	
	var forward := _camera.global_basis.z
	var right := _camera.global_basis.x
	
	var move_direction := forward * raw_input.y + right * raw_input.x 
	move_direction.y = 0.0
	move_direction = move_direction.normalized()
	
	var y_velocity := velocity.y
	velocity.y = 0.0
	velocity = velocity.move_toward(move_direction * move_speed, acceleration * delta)
	velocity.y = y_velocity + _gravity * delta
	
	# Handle Jump
	## Sort out jump animation at somepoint 
	var is_starting_jump := Input.is_action_just_pressed("jump") and is_on_floor()
	if is_starting_jump:
		velocity.y += jump_impulse

	if move_direction.length() > 0: 
		_last_movement_direction = move_direction
	var target_angle := Vector3.BACK.signed_angle_to(_last_movement_direction, Vector3.UP)
	$GroundsKeeper.global_rotation.y = lerp_angle($GroundsKeeper.rotation.y, target_angle, rotation_speed)
	#_skin.global_rotation.y = lerp_angle(_skin.rotation.y, target_angle, rotation_speed)
	
	if is_on_floor():
		$GroundsKeeper/AnimationTree.set("parameters/in_air/transition_request", "false")
		
		if !is_attacking:
			if (raw_input.x != 0 or raw_input.y != 0):
				$GroundsKeeper/AnimationTree.set("parameters/movements/transition_request", "walk")
			else: 
				$GroundsKeeper/AnimationTree.set("parameters/movements/transition_request", "idle")

	# Handle attack 
	if Input.is_action_just_pressed("attack") and is_on_floor():
		is_attacking = true
		$GroundsKeeper/AnimationTree.set("parameters/movements/transition_request", "attack")
		
	move_and_slide()

func _on_area_3d_body_entered(body: Node3D) -> void:
	if body.is_in_group("enemy"):
		body.take_damage()

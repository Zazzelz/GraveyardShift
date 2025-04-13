extends Node3D
@onready var spawns = $Spawns
@onready var navigation_region = $Environment/NavigationRegion3D
@onready var pause_menu: CanvasLayer = $PauseMenu
@onready var player: CharacterBody3D = $Player


var paused = false

var zombie = load("res://05_Zombies/Zombie.tscn")
var instance
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	NavigationServer3D.set_debug_enabled(false)
	randomize()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("pause"):
		_pause_menu()
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE

func _pause_menu():
	if paused:
		pause_menu.hide()
		Engine.time_scale = 1
		
	else: 
		pause_menu.show()
		Engine.time_scale = 0
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
		player._camera_input_direction = Vector2.ZERO
	
	paused = !paused
	
func _get_random_child(parent_node):
	var random_id = randi() % parent_node.get_child_count()
	return parent_node.get_child(random_id)

func _on_zombie_spawn_timer_timeout() -> void:
	var spawn_point = _get_random_child(spawns).global_position
	instance = zombie.instantiate()
	instance.position = spawn_point
	navigation_region.add_child(instance)
	print("Zombie spawned")

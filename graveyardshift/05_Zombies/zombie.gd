extends CharacterBody3D

var player = null
const SPEED = 3

@export var player_path := "/root/Main/Player"
@onready var nav_agent: NavigationAgent3D = $NavigationAgent3D

func _ready() -> void:
	player = get_node(player_path)

func _process(delta: float) -> void:
	velocity = Vector3.ZERO
	
	#Navigation
	nav_agent.set_target_position(player.global_transform.origin)
	
	var next_nav_point = nav_agent.get_next_path_position()
	velocity = (next_nav_point - global_transform.origin).normalized() * SPEED
	#distance = global_position.distance_to(player.global_position)
	
	look_at(Vector3(player.global_position.x, global_position.y, player.global_position.z), Vector3.UP)
	move_and_collide(velocity)

func take_damage():
	queue_free()

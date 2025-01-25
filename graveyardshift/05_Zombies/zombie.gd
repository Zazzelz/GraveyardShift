extends Node3D

@export var stage_path : NodePath

@onready var nav_agent = $NavigationAgent3D
@onready var animation_tree: AnimationTree = $AnimationTree
@onready var animation_player: AnimationPlayer = $AnimationPlayer

const SPEED = 4.0

func _ready() -> void:
	stage_marker = get_node(stage_path)

func _process(delta: float) -> void:
	velocity = Vector3.ZERO
	
	#Navigation
	nav_agent.set_target_position(stage_marker.global_transform.origin)
	
	var next_nav_point = nav_agent.get_next_path_position()
	velocity = (next_nav_point - global_transform.origin).normalized() * SPEED
	distance = global_position.distance_to(stage_marker.global_position)

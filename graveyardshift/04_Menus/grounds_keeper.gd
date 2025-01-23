extends CharacterBody3D

var stage_marker = null
var dance_range = 0.5

@export var stage_path : NodePath

@onready var nav_agent = $NavigationAgent3D
@onready var animation_tree: AnimationTree = $AnimationTree

const SPEED = 4.0

func _ready() -> void:
	stage_marker = get_node(stage_path)

func _process(delta: float) -> void:
	velocity = Vector3.ZERO
	
	#Navigation
	nav_agent.set_target_position(stage_marker.global_transform.origin)
	
	var next_nav_point = nav_agent.get_next_path_position()
	velocity = (next_nav_point - global_transform.origin).normalized() * SPEED
	
	#look_at(Vector3(stage_marker.global_position.x, global_position.y, global_position.z), Vector3.UP)
	
	#Conditions
	animation_tree.set("parameters/conditions/MenuDance1", _target_in_range())
	
	
	move_and_slide()

func _target_in_range():
	return global_position.distance_to(stage_marker.global_position) < dance_range
	
	

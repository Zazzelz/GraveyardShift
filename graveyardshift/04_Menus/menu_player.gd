extends Node3D

@onready var animation_player: AnimationPlayer = $BasePose/AnimationPlayer


func _ready():
	animation_player.play("PlayerAnimations_Walk")
	animation_player.queue("PlayerAnimations_Thriller01")
	animation_player.play("PlayerAnimations_Thriller01")

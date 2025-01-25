class_name GroundsKeeper 
extends Node3D

@onready var animation_tree: AnimationTree = $"../AnimationTree"
@onready var state_machine : AnimationNodeStateMachinePlayback = animation_tree.get("parameters/StateMachine/playback")


func idle():
	state_machine.travel("PlayerAnimations_Idle")
	
func walk():
	state_machine.travel("PlayerAnimations_Walk")
	
func jump():
	state_machine.travel("PlayerAnimations_Jump")

func attack():
	state_machine.travel("PlayerAnimations_HeavyAttack")
	

class_name IdleState
extends State

const is_idle_condition := "parameters/conditions/is_idle"

@export var animatable : AnimatableNode3D

func enter() -> void:
	super.enter()
	animatable.animation_tree[is_idle_condition] = true


func cancel() -> void:
	super.cancel()
	animatable.animation_tree[is_idle_condition] = false


func exit() -> void:
	super.exit()
	animatable.animation_tree[is_idle_condition] = false

class_name MoveToState
extends State

const is_moving_condition := "parameters/conditions/is_moving"

@export var agent: CharacterBodyNavigationAgent3D
@export var animatable : AnimatableNode3D
var params: MoveToStateParams


func init(params: Variant) -> void:
	super.init(params)
	if params is not MoveToStateParams:
		cancel()
		return
	self.params = params


func enter() -> void:
	super.enter()
	agent.target_reached.connect(_on_target_reached)
	var success = agent.try_move_to(params.destination)
	animatable.animation_tree[is_moving_condition] = true


func cancel() -> void:
	super.cancel()
	if agent.target_reached.is_connected(_on_target_reached):
		agent.target_reached.disconnect(_on_target_reached)
	animatable.animation_tree[is_moving_condition] = false


func exit() -> void:
	super.exit()
	if agent.target_reached.is_connected(_on_target_reached):
		agent.target_reached.disconnect(_on_target_reached)		
	animatable.animation_tree[is_moving_condition] = false


func _on_target_reached() -> void:
	exit()

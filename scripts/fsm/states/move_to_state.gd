class_name MoveToState
extends State

@export var movement: MovementComponent
var params: MoveToStateParams


func init(params: Variant) -> void:
	super.init(params)
	if params is not MoveToStateParams:
		cancel()
		return
	self.params = params


func enter() -> void:
	super.enter()
	movement.target_reached.connect(_on_target_reached)
	var success = movement.try_move_to(params.destination)
	if !success:
		cancel()


func cancel() -> void:
	super.cancel()
	if movement.target_reached.is_connected(_on_target_reached):
		movement.target_reached.disconnect(_on_target_reached)


func exit() -> void:
	super.exit()
	if movement.target_reached.is_connected(_on_target_reached):
		movement.target_reached.disconnect(_on_target_reached)		


func _on_target_reached() -> void:
	exit()

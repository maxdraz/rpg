class_name PlayerController
extends Node3D

@export var input_controller: InputController
@export var state_machine: StateMachine


func _ready() -> void:
	input_controller.left_click.connect(_on_left_click)
	input_controller.right_click.connect(_on_right_click)


func _on_left_click(event: InputEvent) -> void:
	var result = raycast_from_mouse()
	if !result or result.size() <= 0: return
	if result.collider is Entity:
		var params = CombatStateParams.new(self, result.collider)
		state_machine.transition_to(CombatState, params)
	else:
		var params = MoveToStateParams.new(result.position)
		state_machine.transition_to(MoveToState, MoveToStateParams.new(result.position))

func _on_right_click(event: InputEvent) -> void:
	pass


func raycast_from_mouse() -> Dictionary:
	var camera = get_viewport().get_camera_3d()
	if not camera:
		return {}
	var mouse_pos = get_viewport().get_mouse_position()
	var origin = camera.project_ray_origin(mouse_pos)
	var end = origin + camera.project_ray_normal(mouse_pos) * 1000
	var space_state = get_world_3d().direct_space_state
	var query = PhysicsRayQueryParameters3D.create(origin, end)
	return space_state.intersect_ray(query)

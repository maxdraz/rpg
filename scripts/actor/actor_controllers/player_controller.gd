class_name PlayerController
extends Node3D


@export var actor : Actor


func _unhandled_input(event: InputEvent) -> void:
	handle_left_click(event)


func handle_left_click(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		var result = raycast_from_mouse_pos(event.position)
		if result:
			if result is Interactable:
				result.interact()
			else:
				actor.move_to(result.position)


func raycast_from_mouse_pos(mouse_pos: Vector2) -> Variant:
	var camera = get_viewport().get_camera_3d()
	if !camera:
		return null
	var ray_length = 1000
	var from = camera.project_ray_origin(mouse_pos)
	var to = from + camera.project_ray_normal(mouse_pos) * ray_length
	var space_state = get_world_3d().direct_space_state
	var query = PhysicsRayQueryParameters3D.create(from, to)
	
	return space_state.intersect_ray(query)

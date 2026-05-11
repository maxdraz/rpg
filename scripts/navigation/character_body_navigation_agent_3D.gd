class_name CharacterBodyNavigationAgent3D
extends NavigationAgent3D


@export var body: CharacterBody3D
@export var speed:= 5.0

func _physics_process(_delta: float) -> void:
	
	if is_navigation_finished():
		return
	var next_velocity = get_next_path_position() - body.global_transform.origin
	next_velocity.y = 0
	next_velocity = next_velocity.normalized() * speed
	body.velocity.x = next_velocity.x
	body.velocity.z = next_velocity.z
	body.move_and_slide()
	body.look_at(body.global_transform.origin + next_velocity, Vector3.UP, true)


func try_move_to(position: Vector3) -> bool:
	var tmp = target_position
	target_position = position
	var is_reachable = is_target_reachable()
	if !is_reachable:
		target_position = tmp
	return is_reachable

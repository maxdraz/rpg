class_name WanderState
extends State

@export var entity: Entity
@export var movement: MovementComponent
@export var dist_min := 1.0
@export var dist_max := 5.0
@export var interval_min := 1.0
@export var interval_max := 2.0

func enter() -> void:
	super.enter()
	movement.target_reached.connect(_on_target_reached)
	move_to_random_waypoint()


func cancel() -> void:
	super.cancel()
	movement.target_reached.disconnect(_on_target_reached)


func exit() -> void:
	super.exit()
	movement.target_reached.disconnect(_on_target_reached)


func move_to_random_waypoint() -> void:
	var success = movement.try_move_to(get_random_waypoint())
	if !success: print("no success")


func get_random_waypoint() -> Vector3:
	var direction := Vector3(randf(), 0 ,randf()).normalized()
	return entity.global_position + direction * randf_range(dist_min, dist_max)


func _on_target_reached() -> void:
	var random_interval := randf_range(interval_min, interval_max)
	await get_tree().create_timer(random_interval).timeout
	move_to_random_waypoint()

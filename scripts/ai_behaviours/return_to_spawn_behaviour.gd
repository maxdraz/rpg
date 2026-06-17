class_name ReturnToSpawnBehaviour
extends AIBehaviour

@export var entity: Entity
@export var state_machine: StateMachineComponent
@export var max_distance := 20.0

var spawn_position: Vector3


func _ready() -> void:
    spawn_position = entity.global_position


func is_conditions_met() -> bool:
    return entity.global_position.distance_squared_to(spawn_position) > max_distance * max_distance


func execute() -> void:
    super.execute()
    var random_position = get_random_point_around_spawn()
    state_machine.transition_to(MoveToState, MoveToStateParams.new(random_position))
    state_machine.state_changed.connect(_on_state_machine_state_changed)


func cancel() -> void:
    super.cancel() 
    state_machine.state_changed.disconnect(_on_state_machine_state_changed)


func _on_state_machine_state_changed(old_state: State, new_state: State) -> void:
    state_machine.state_changed.disconnect(_on_state_machine_state_changed)
    exit()
    print("return to spawn exited")


func get_random_point_around_spawn() -> Vector3:
    var rand_dir = Vector3(randf_range(-1.0, 1.0), spawn_position.y, randf_range(-1.0, 1.0)).normalized()
    var offset = rand_dir * (randf() * max_distance * 0.5)
    return spawn_position + offset
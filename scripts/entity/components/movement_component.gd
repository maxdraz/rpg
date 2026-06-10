class_name MovementComponent
extends EntityComponent

@export var agent: CharacterBodyNavigationAgent3D
signal target_reached

func _ready() -> void:
	agent.target_reached.connect(_on_target_reached)


func try_move_to(position: Vector3, arrive_distance := 1.0) -> bool:
	return agent.try_move_to(position, arrive_distance)


func _on_target_reached() -> void:
	target_reached.emit()
  

class_name CameraRig3D
extends Node3D

@export var camera : Camera3D
@export var follow_target : Node3D
@export var follow_speed := 10.0
@export var sensitivity := 0.25
@export var update_in_physics_process: bool
var offset: Vector3
var pivot: Vector3
var is_rotating: bool
var yaw: float

func _ready() -> void:
	offset = global_position - follow_target.global_position
	pivot = follow_target.global_position

func _process(delta: float) -> void:
	if update_in_physics_process: return
	pivot = pivot.lerp(follow_target.global_position, follow_speed * delta)
	global_position = pivot + offset

func _physics_process(delta: float) -> void:
	if !update_in_physics_process: return
	pivot = pivot.lerp(follow_target.global_position, follow_speed * delta)
	global_position = pivot + offset

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_RIGHT:
		is_rotating = event.is_pressed()
	
	if is_rotating and event is InputEventMouseMotion:
		yaw -= event.relative.x * sensitivity
		yaw = fmod(yaw, 360.0)
		rotation.y = deg_to_rad(yaw)
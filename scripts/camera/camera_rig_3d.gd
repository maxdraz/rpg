class_name CameraRig3D
extends Node3D

@export var camera : Camera3D
@export var camera_holder : Node3D
@export var follow_target : Node3D
@export var follow_speed := 10.0
@export var sensitivity := 0.25
@export var update_in_physics_process: bool
@export var zoom := 10.0
var offset: Vector3
var pivot: Vector3
var is_rotating: bool
var yaw: float
var pitch: float


func _ready() -> void:
	offset = global_position - follow_target.global_position
	pivot = follow_target.global_position
	zoom_delta(0)
	pitch_delta(0)
	yaw_delta(0)


func _process(delta: float) -> void:
	if update_in_physics_process: return
	pivot = pivot.lerp(follow_target.global_position, follow_speed * delta)
	global_position = pivot + offset


func _physics_process(delta: float) -> void:
	if !update_in_physics_process: return
	pivot = pivot.lerp(follow_target.global_position, follow_speed * delta)
	global_position = pivot + offset


func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		match event.button_index:
			MOUSE_BUTTON_RIGHT:
				is_rotating = event.is_pressed()
			MOUSE_BUTTON_WHEEL_UP:
				zoom_delta(-2.0 * sensitivity)
			MOUSE_BUTTON_WHEEL_DOWN:
				zoom_delta(2.0 * sensitivity)

	if is_rotating and event is InputEventMouseMotion:
		yaw_delta(event.relative.x * sensitivity)
		pitch_delta(event.relative.y * sensitivity)


func zoom_delta(delta: float) -> void:
	zoom += delta
	zoom = clampf(zoom, 3.0, 10.0)
	camera_holder.position.z = zoom


func yaw_delta(delta: float) -> void:
	yaw -= delta 
	yaw = fmod(yaw, 360.0)
	rotation.y = deg_to_rad(yaw)


func pitch_delta(delta: float) -> void:
	pitch -= delta 
	pitch = clampf(pitch, -60.0, 0.0)
	rotation.x = deg_to_rad(pitch)
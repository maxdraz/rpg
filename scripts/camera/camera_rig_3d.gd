class_name CameraRig3D
extends Node3D

@export var camera : Camera3D
@export var follow_target : Node3D
@export var follow_speed := 10.0
@export var update_in_physics_process: bool
var offset : Vector3
var pivot : Vector3

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

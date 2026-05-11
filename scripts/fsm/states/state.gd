class_name State
extends Node

signal canceled
signal exited


func get_id() -> String:
	return ""


func init(params: StateParams) -> void:
	pass


func enter() -> void:
	pass


func process(delta: float) -> void:
	pass


func physics_process(delta: float) -> void:
	pass


func cancel() -> void:
	canceled.emit()


func exit() -> void:
	exited.emit()
class_name State
extends Node

signal exited


func init(params: Variant) -> void:
	pass


func enter() -> void:
	print(name + " entered")
	pass


func process(delta: float) -> void:
	pass


func physics_process(delta: float) -> void:
	pass


func cancel() -> void:
	print(name + " canceled")
	pass


func exit() -> void:
	print(name + " exited")
	exited.emit()
	pass

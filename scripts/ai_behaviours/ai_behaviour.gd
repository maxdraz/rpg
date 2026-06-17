class_name AIBehaviour
extends Node

@export var priority: int

signal exited(behaviour: AIBehaviour)


func is_conditions_met() -> bool:
	return false


func execute() -> void:
	pass


func cancel() -> void: 
	pass


func exit() -> void:
	exited.emit(self)

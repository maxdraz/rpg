class_name State
extends Node

signal exited


func init(params: Variant) -> void:
	pass


func enter() -> void:
	print(str(self.get_script()) + " entered")
	pass


func process(delta: float) -> void:
	pass


func physics_process(delta: float) -> void:
	pass


func cancel() -> void:
	print(str(self.get_script()) + " canceled")
	pass


func exit() -> void:
	print(str(self.get_script()) + " exited")
	pass

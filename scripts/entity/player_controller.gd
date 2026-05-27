class_name PlayerController
extends Node

@export var input_controller: InputController
@export var state_machine: StateMachine


func _ready() -> void:
	input_controller.left_click.connect(_on_left_click)
	input_controller.left_click.connect(_on_right_click)


func _on_left_click(event: InputEvent) -> void:
	print("left clicked")

func _on_right_click(event: InputEvent) -> void:
	print("right clicked")

class_name InputController
extends Node

signal left_click(event: InputEvent)
signal right_click(event: InputEvent)


func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.pressed:
		if event.button_index == MOUSE_BUTTON_LEFT:
			left_click.emit(event)
		elif event.button_index == MOUSE_BUTTON_RIGHT:
			right_click.emit(event)

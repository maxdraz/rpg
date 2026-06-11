extends Node

signal emitted(event: Event)

func emit(event: Event) -> void:
	emitted.emit(event)
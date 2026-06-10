class_name EventBusComponent
extends EntityComponent

signal emitted(event: Event, params: Variant, is_global: bool)

func emit(event: Event, is_global := false) -> void:
	emitted.emit(event, is_global)

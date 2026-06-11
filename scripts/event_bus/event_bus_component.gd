class_name EventBusComponent
extends EntityComponent

signal emitted(event: Event)

func emit(event: Event, is_global := false) -> void:
	emitted.emit(event)
	if is_global: 
		EventBus.emitted.emit(event)

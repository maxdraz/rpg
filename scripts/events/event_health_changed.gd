class_name EventHealthChanged
extends Event

var new_value: float
var old_value: float


func _init(new_value: float, old_value: float) -> void:
	self.new_value = new_value
	self.old_value = old_value

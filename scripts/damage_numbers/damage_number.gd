class_name DamageNumber
extends Node3D

@export var label: Label3D


func initialize(position: Vector3, text: String) ->void:
	global_position = position
	label.text = text
	animate()


func animate() -> void:
	var tween = create_tween()
	tween.set_ease(Tween.EASE_IN_OUT)
	tween.set_trans(Tween.TRANS_SINE)
	tween.tween_property(label, "position:y", 0.5, 0.75).as_relative()
	tween.tween_callback(queue_free)

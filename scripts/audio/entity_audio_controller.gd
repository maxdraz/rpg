class_name EntityAudioController
extends Node

@export var audio_stream_player: AudioStreamPlayer
@export var audio_stream_player_3d: AudioStreamPlayer3D
@export var input: InputController
@export var click: AudioStream

func _ready() -> void:
	if input: input.left_click.connect(_on_left_click)


func _on_left_click(event: InputEvent) -> void:
	print("playing left click")
	play(click)


func play(sfx: AudioStream) -> void:
	audio_stream_player.stream = sfx
	audio_stream_player.play()


func play_3d(sfx: AudioStream) -> void:
	audio_stream_player_3d.stream = sfx
	audio_stream_player_3d.play()
	audio_stream_player_3d.play()

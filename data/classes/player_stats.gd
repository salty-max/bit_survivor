class_name PlayerStats
extends Stats

@export_category("Visuals")
@export var frames: SpriteFrames
@export_category("Data")
@export var max_health: float : set = _set_max_health
@export var health: float : set = _set_health
@export var speed: float


func _set_max_health(value: float) -> void:
	max_health = value
	emit_changed()


func _set_health(value: float) -> void:
	health = value
	emit_changed()

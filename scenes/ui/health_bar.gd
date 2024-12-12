class_name HealthBar
extends ProgressBar

@onready var damage_bar: ProgressBar = %DamageBar
@onready var timer: Timer = %Timer

var health: float : set = _set_health
var max_health: float : set = _set_max_health


func _set_health(new_health: float) -> void:
	var prev_health := health
	health = min(max_value, new_health)
	value = health

	if health <= 0:
		queue_free()

	if health < prev_health:
		timer.start()
	else:
		damage_bar.value = health


func _set_max_health(new_value: float) -> void:
	max_health = new_value
	max_value = max_health
	damage_bar.max_value = max_health


func init_values(base_health: float) -> void:
	health = base_health
	max_value = health
	value = health
	damage_bar.max_value = health
	damage_bar.value = health


func _on_timer_timeout() -> void:
	damage_bar.value = health

class_name EnemySpawner
extends Node

const MINUTE_IN_SECONDS: int = 10

@export var player: Player
@export var enemy_scene: PackedScene
@export var enemy_types: Array[EnemyStats]

@onready var minutes_label: Label = %MinutesLabel
@onready var seconds_label: Label = %SecondsLabel
@onready var enemies: Node = %Enemies

var distance: float = 400
var minutes: int : set = _set_minutes
var seconds: int : set = _set_seconds


func _set_minutes(value: int) -> void:
	minutes = value
	minutes_label.text = str(minutes)


func _set_seconds(value: int) -> void:
	seconds = value
	if seconds >= MINUTE_IN_SECONDS:
		seconds -= MINUTE_IN_SECONDS
		minutes += 1
	seconds_label.text = str(seconds).lpad(2, '0')


func spawn(pos: Vector2) -> void:
	var enemy := enemy_scene.instantiate() as Enemy
	var stats := enemy_types[min(minutes, enemy_types.size() - 1)]

	enemy.name = "%s%s" % [stats.name, enemies.get_child_count()]
	enemy.stats = stats
	enemy.target = player
	enemy.position = pos
	enemies.add_child(enemy)


func get_random_position() -> Vector2:
	return player.position + distance * Vector2.RIGHT.rotated(randf_range(0, 2 * PI))


func spawn_multiple(amount: int) -> void:
	for i in range(amount):
		spawn(get_random_position())


func _on_normal_timer_timeout() -> void:
	seconds += 1
	spawn_multiple(seconds % MINUTE_IN_SECONDS)

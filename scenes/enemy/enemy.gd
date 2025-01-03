class_name Enemy
extends CharacterBody2D

@export var target: Player
@export var speed: float = 75

@onready var sprite: AnimatedSprite2D = $Sprite

var direction: Vector2

var stats: EnemyStats : set = _set_stats
var damage: float


func _set_stats(value: EnemyStats) -> void:
	stats = value

	if not is_node_ready():
		await ready

	sprite.sprite_frames = stats.frames
	damage = stats.damage


func _ready() -> void:
	sprite.play("default")


func _physics_process(delta: float) -> void:
	if not target:
		return

	velocity = (target.position - position).normalized() * speed
	move_and_collide(velocity * delta)

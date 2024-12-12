class_name Player
extends CharacterBody2D

@export var stats: PlayerStats : set = _set_stats

@onready var sprite: AnimatedSprite2D = $Sprite
@onready var health_bar: HealthBar = $HealthBar
@onready var hurt_box_collision_shape: CollisionShape2D = %HurtBoxCollisionShape


func _set_stats(value: PlayerStats) -> void:
	stats = value

	if not is_node_ready():
		await ready

	sprite.sprite_frames = stats.frames
	health_bar.init_values(stats.max_health)
	stats.changed.connect(_on_stats_changed)


func _ready() -> void:
	sprite.play("default")


func _physics_process(delta: float) -> void:
	velocity = Input.get_vector("move_left", "move_right", "move_up", "move_down").normalized() * stats.speed
	move_and_collide(velocity * delta)


func take_damage(amount: float) -> void:
	stats.health -= amount

	if stats.health <= 0:
		queue_free()


func _on_stats_changed() -> void:
	health_bar.health = stats.health
	health_bar.max_health = stats.max_health


func _on_hurt_box_body_entered(body: Node2D) -> void:
	if body is Enemy:
		take_damage(body.damage)


func _on_timer_timeout() -> void:
	hurt_box_collision_shape.set_deferred("disabled", true)
	hurt_box_collision_shape.set_deferred("disabled", false)

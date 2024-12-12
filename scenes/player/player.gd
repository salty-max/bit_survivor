class_name Player
extends CharacterBody2D


@export var speed: float = 150

@onready var sprite: AnimatedSprite2D = $Sprite


func _ready() -> void:
	sprite.play("default")


func _physics_process(delta: float) -> void:
	velocity = Input.get_vector("move_left", "move_right", "move_up", "move_down").normalized() * speed
	move_and_collide(velocity * delta)

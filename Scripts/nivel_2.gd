extends Node2D

@onready var trash_scene = preload("res://scenes/Personajes/trash.tscn")


func _on_timer_timeout() -> void:
	var trash = trash_scene.instantiate()
	trash.position.x = randi_range(0,get_viewport().size.x)
	trash.position.y = 0
	add_child(trash)

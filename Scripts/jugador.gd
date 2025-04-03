extends CharacterBody2D

var speed = 200
var jump_power = -600
var gravity = 980
var trash_collected = 0
#@export var moneda_llena: Texture2D
@onready var animation_player = $animaciones


func _physics_process(delta: float) -> void:
	
	velocity.y += gravity * delta
	var direction= Vector2.ZERO
	
	if Input.is_action_pressed("right"):
		direction.x += 1
	
	elif Input.is_action_pressed("left"):
		direction.x -= 1
		
	if is_on_floor() and Input.is_action_just_pressed("jump"):
		velocity.y = jump_power
		
	velocity.x = direction.x * speed
	
	if velocity.x > 0:
		$animaciones.flip_h = false  # Mirando a la derecha
	elif velocity.x < 0:
		$animaciones.flip_h = true   # Mirando a la izquierda
	
	update_animation()
	move_and_slide()

func update_animation():
	if not is_on_floor():
		if velocity.y < 0 :
			animation_player.play("jump")
		else:
			animation_player.play("fall")
			
	elif velocity.x != 0 :
		if Input.is_action_pressed("right"):
			animation_player.play("right")
		elif Input.is_action_pressed("left"):
			animation_player.play("right")
			
	else:
		animation_player.play("idle")

func _on_area_2d_body_entered(body):
	if body.is_in_group("objeto"):
		trash_collected +=10
		body.queue_free()
		$CanvasLayer/ProgressBar.value = trash_collected
		update_progress_bar()
		
func update_progress_bar():
	var progress = $CanvasLayer/ProgressBar
	var valor = progress.value
	
	if valor <= 25:
		progress.add_theme_color_override("font_color", Color(1, 0, 0))  # Rojo
	elif valor <= 50:
		progress.add_theme_color_override("font_color", Color(1, 0.5, 0))  # Naranja
	elif valor <= 75:
		progress.add_theme_color_override("font_color", Color(1, 1, 0))  # Amarillo
	else:
		progress.add_theme_color_override("font_color", Color(0, 1, 0))  # Verde
		
	
		
	





























#func add():
	
	#for diamante in $diamantes.get_children():
		#if diamante.texture.get_path() == "res://icon.svg":
			#diamante.texture = moneda_llena
			#break

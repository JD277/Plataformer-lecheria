extends CharacterBody2D
var intentos = 3
var speed = 200
var jump_power = -400
var gravity = 980
var trash_collected = 0
var trash_collected_maximos = 100
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

func _on_area_2d_body_entered(area):
	print("📍 Área detectada: ", area.name, " (grupo: enemigo = ", area.is_in_group("enemigo"), ")")
	if area.is_in_group("objeto"):
		trash_collected +=10
		area.queue_free()
		$CanvasLayer/ProgressBar.value = trash_collected
		update_progress_bar()
	if body.name == "spikes" and get_parent().name == "Nivel1":
		intentos -= 1
		if intentos <= 0:
			intentos = 3
		get_parent().derrota(intentos, -5, 577)
	if body.name == "water" and get_parent().name == "Nivel1":
		pass
		#get_tree().change_scene_to_file()
		
	
func update_progress_bar():
	#var progress = $CanvasLayer/ProgressBar
	#var valor = progress.value
	
	#if valor <= 25:
		#progress.add_theme_color_override("font_color", Color(1, 0, 0))  # Rojo
	#elif valor <= 50:
		#progress.add_theme_color_override("font_color", Color(1, 0.5, 0))  # Naranja
	#elif valor <= 75:
		#progress.add_theme_color_override("font_color", Color(1, 1, 0))  # Amarillo
	#else:
		#progress.add_theme_color_override("font_color", Color(0, 1, 0))  # Verde
	
	# Primero actualiza el valor del ProgressBar
	var progress = $CanvasLayer/ProgressBar
	var valor = progress.value
	
	# Crear un nuevo StyleBoxFlat para el fondo
	var style_box = StyleBoxFlat.new()
	
	# Configurar el color según el valor
	if valor <= 25:
		style_box.bg_color = Color(1, 0, 0)    # Rojo
	elif valor <= 50:
		style_box.bg_color = Color(1, 0.5, 0)  # Naranja
	elif valor <= 75:
		style_box.bg_color = Color(1, 1, 0)    # Amarillo
	else:
		style_box.bg_color = Color(0, 1, 0)    # Verde
	
	# Aplicar el estilo al fondo del ProgressBar
	progress.add_theme_stylebox_override("fill", style_box)
	
#segundo nivel
# funcion para restar pustos que es llamada dede el enemigo para su correcto funcionamiento
func restar_puntos(cantidad):
	trash_collected = trash_collected - cantidad
	if trash_collected < 0:
		trash_collected = 0
	print("💥 Daño recibido: -", cantidad, " | trash_collected actuales: ", trash_collected)
	$CanvasLayer/ProgressBar.value = trash_collected
	update_progress_bar()













#func add():
	
	#for diamante in $diamantes.get_children():
		#if diamante.texture.get_path() == "res://icon.svg":
			#diamante.texture = moneda_llena
			#break

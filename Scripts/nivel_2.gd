extends Node2D
const nivel = "Nivel 2"
var x = 32
var y = 256
var stop_animation = true
@onready var trash_scene = preload("res://scenes/Personajes/trash.tscn")

func _ready() -> void:
	# Se muestra la transición de entrada
	$Jugador.move = false
	$ave.move = false
	$salida.visible = false 
	$entrada.start("desvanecer")
	$stop.start()
	await $stop.timeout
	$Jugador.move = true
	$ave.move = true

func _on_timer_timeout() -> void:
	var trash = trash_scene.instantiate()
	trash.position.x = randi_range(0,get_viewport().size.x)
	trash.position.y = 0
	add_child(trash)

func _process(delta: float) -> void:
	var basura = $Jugador/CanvasLayer/ProgressBar.value
	if basura == 30 and stop_animation == true: # lógica para pasar de nivel
		$Jugador.move = false
		$ave.move = false
		$animations.play("Victoria definitiva")
		$"game over/Ir a Inicio".visible = true
		$Timer.stop()
		$animations.play("VICTORIA")
		$"game over/intentos".text = nivel + str(" Completdo")
		$stop.start()
		stop_animation = false
		await $stop.timeout
		
		
# Animación de derrota
func derrota(intentos,x,y):
	if $Jugador.intentos < 3:
		$Jugador/CanvasLayer/ProgressBar.value = 0
		$Jugador.trash_collected= 0
	if $Jugador.intentos <= 0:
		$Jugador.move = false
		$animations.play("Derrota definitiva")
		$"game over/Continuar".visible = true
		$"game over/Ir a Inicio".visible = true
		$Timer.stop()
		$animations.play("derrota")
		$"game over/intentos".text = "vidas restantes: " + str(intentos)
		$Jugador.move = true
	if $Jugador.intentos != 0:
		$Jugador.move = false
		$Timer.stop()
		$animations.play("derrota")
		$"game over/intentos".text = "vidas restantes: " + str(intentos)
		$stopGameover.start()
		await $stopGameover.timeout
		$Jugador.position.x = x
		$Jugador.position.y = y
		$animations.play("derrota afuera")
		$stopGameover.start()
		await $stopGameover.timeout
		$Jugador.move = true
		return true


func _on_continuar_pressed():
	$Jugador.intentos = 3
	$Jugador.trash_collected= 0
	$"game over/Continuar".visible = false
	$"game over/Ir a Inicio".visible = false
	$stopGameover.start()
	await $stopGameover.timeout
	$Jugador.position.x = x
	$Jugador.position.y = y
	$animations.play("derrota afuera")
	$stopGameover.start()
	await $stopGameover.timeout
	return true

func _on_ir_a_inicio_pressed():
	get_tree().change_scene_to_file("res://scenes/menu_de_inicio.tscn")
	

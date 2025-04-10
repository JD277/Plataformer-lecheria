extends Node2D

@onready var trash_scene = preload("res://scenes/Personajes/trash.tscn")
func _ready() -> void:
	# Se muestra la transición de entrada
	$salida.visible = false 
	$entrada.start("desvanecer")
	$stop.start()
	await $stop.timeout

func _on_timer_timeout() -> void:
	var trash = trash_scene.instantiate()
	trash.position.x = randi_range(0,get_viewport().size.x)
	trash.position.y = 0
	add_child(trash)

func _process(delta: float) -> void:
	var basura = $Jugador/CanvasLayer/ProgressBar.value
	if basura == 100: # lógica para pasar de nivel 
		$spikes.visible = false
		$spikes.collision_enabled = false

# Animación de derrota
func derrota(intentos,x,y):
	if $Jugador.intentos <= 0:
		$Jugador/CanvasLayer/ProgressBar.value = 0
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
	return true

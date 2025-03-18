extends Node2D

@export var historia: Array[String]
@onready var nodo_texto = $texto

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$salida.visible = false
	$entrada.start("desvanecer")
	$stop.start()
	await $stop.timeout
	$entrada.visible = false
	await mostrar_texto() 
	$salida.visible = true
	$salida.start("desvanecer invertido")
	$stop.start()
	await $stop.timeout
	$salida.visible = false
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

# Muestra el texto poco a poco en la caja de texto 
func mostrar_texto():
	for texto in historia:
		for letra in texto:
			$timer.start()
			nodo_texto.text = nodo_texto.text + letra
			nodo_texto.queue_redraw()
			await $timer.timeout
		await esperar_input()
		nodo_texto.text = ""
		
	return true

# Función para esperar la entrada del jugador.
func esperar_input():
	while not Input.is_action_just_pressed("ui_accept"):
		await get_tree().physics_frame # Esperar un frame

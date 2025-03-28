extends CharacterBody2D

var speed = 200
var jump_power = -500
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
			animation_player.play("left")
			
	else:
		animation_player.play("idle")

#func add():
	
	#for diamante in $diamantes.get_children():
		#if diamante.texture.get_path() == "res://icon.svg":
			#diamante.texture = moneda_llena
			#break



func _on_area_2d_body_entered(body):
	if body.is_in_group("objeto"):
		trash_collected +=1
		print(trash_collected)

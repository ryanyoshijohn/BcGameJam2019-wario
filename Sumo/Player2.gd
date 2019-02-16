extends KinematicBody2D

var speed = 400
var velocity = Vector2()
var friction = 0.3

#timer
var timer = null
var stun_duration = 2
var hitstun = false


func hit(vel):
	hitstun = true
	get_parent().get_node("HitStun2").start()
	velocity = vel

func _physics_process(delta):
	if (Input.is_key_pressed(KEY_D) && !hitstun):
		velocity.x = speed
	if Input.is_key_pressed(KEY_A) && !hitstun:
		velocity.x = -speed
	if Input.is_key_pressed(KEY_S) && !hitstun:
		velocity.y = speed
	if Input.is_key_pressed(KEY_W) && !hitstun:
		velocity.y = -speed
	
	if (velocity.x > 0):
		velocity.x -= 10
		
	if (velocity.x < 0):
		velocity.x += 10
	
	if (velocity.y > 0):
		velocity.y -= 10
	
	if (velocity.y < 0):
		velocity.y += 10
	
	var collision = move_and_collide(velocity * delta)
	if collision:
		hitstun = true
		get_parent().get_node("HitStun2").start()
		get_parent().get_node("LoopFix2").start()
		if(collision.collider.has_method("hit")):
			get_parent().get_node("Player3").hit(velocity*2)

func _on_HitStun2_timeout():
	hitstun = false


func _on_LoopFix2_timeout():
	velocity = -velocity / 2


func _on_VisibilityNotifier2D_screen_exited():
	print("deleted")
	queue_free()

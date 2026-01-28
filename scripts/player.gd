extends CharacterBody2D

const SPEED = 100.0

@onready var ray_cast = $RayCast2D

var last_direction = Vector2(0, 1) # Default facing down

func _ready():
	print("Player script is READY and running!")
	# Ensure RayCast ignores the player itself (usually default but good to be safe)
	ray_cast.add_exception(self)

func _unhandled_input(event):
	# Handle Interaction Input
	# Using unhandled_input ensures that if the DialogueManager (or UI) handles the key, 
	# this won't fire.
	if event.is_action_pressed("ui_accept"):
		ray_cast.force_raycast_update() # Update immediately before checking
		if ray_cast.is_colliding():
			var collider = ray_cast.get_collider()
			# print("RayCast hit: ", collider.name)
			if collider.is_in_group("interactable"):
				if collider.has_method("interact"):
					collider.interact()
		# else:
			# print("RayCast missed. Target pos: ", ray_cast.target_position)

func _physics_process(_delta):
	if DialogueManager.is_dialogue_active:
		return # Stop movement during dialogue
		
	var input_vector = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	
	if input_vector != Vector2.ZERO:
		velocity = input_vector * SPEED
		last_direction = input_vector # Update facing direction
		
		# Rotate RayCast to face movement direction
		# We normalize it to snap to 4 directions if we want cleaner raycasts, 
		# or just use the vector. For 4-way visual, snapping is better.
		if abs(input_vector.x) > abs(input_vector.y):
			ray_cast.target_position = Vector2(input_vector.x, 0).normalized() * 40 # Increased length
		else:
			ray_cast.target_position = Vector2(0, input_vector.y).normalized() * 40
	else:
		velocity = Vector2.ZERO
		
		# Ensure RayCast stays facing the last direction
		if abs(last_direction.x) > abs(last_direction.y):
			ray_cast.target_position = Vector2(last_direction.x, 0).normalized() * 40
		else:
			ray_cast.target_position = Vector2(0, last_direction.y).normalized() * 40

	move_and_slide()

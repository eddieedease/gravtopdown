extends Node

# Signal to notify when dialogue starts/ends (useful for pausing gameplay)
signal dialogue_started
signal dialogue_ended

var dialogue_data = {}
var current_dialogue_lines = []
var current_line_index = 0
var is_dialogue_active = false

var dialogue_ui_scene = preload("res://scenes/helpers/dialogue_box.tscn")
var dialogue_ui_instance = null

func _ready():
	load_dialogue_data()

func load_dialogue_data():
	var file = FileAccess.open("res://data/dialogue.json", FileAccess.READ)
	if file:
		var json_text = file.get_as_text()
		var json = JSON.new()
		var error = json.parse(json_text)
		if error == OK:
			dialogue_data = json.data
			print("Dialogue data loaded successfully.")
		else:
			print("JSON Parse Error: ", json.get_error_message(), " in ", json_text, " at line ", json.get_error_line())
	else:
		print("Could not open dialogue.json")

func start_dialogue(npc_id: String):
	if is_dialogue_active:
		return
		
	if dialogue_data.has(npc_id):
		current_dialogue_lines = dialogue_data[npc_id]
		current_line_index = 0
		is_dialogue_active = true
		emit_signal("dialogue_started")
		show_dialogue_ui()
		show_next_line()
	else:
		print("Dialogue ID not found: ", npc_id)

func show_dialogue_ui():
	# Instantiate the UI if it doesn't exist (or just show it if it's already in the scene tree)
	# For simplicity, we'll instantiate it on the CanvasLayer of the current scene or add it to the window.
	# A better approach for a global system is to have a dedicated CanvasLayer in the Autoload, 
	# but Autoloads are Nodes not CanvasLayers by default.
	# We will add it to the current scene's root.
	
	if dialogue_ui_instance == null:
		dialogue_ui_instance = dialogue_ui_scene.instantiate()
		get_tree().root.add_child(dialogue_ui_instance)
	
	dialogue_ui_instance.visible = true

func show_next_line():
	if current_line_index < current_dialogue_lines.size():
		var text = current_dialogue_lines[current_line_index]
		if dialogue_ui_instance:
			dialogue_ui_instance.set_text(text)
		current_line_index += 1
	else:
		end_dialogue()

func end_dialogue():
	is_dialogue_active = false
	if dialogue_ui_instance:
		dialogue_ui_instance.visible = false
	emit_signal("dialogue_ended")

func _input(event):
	if is_dialogue_active and event.is_action_pressed("ui_accept"):
		show_next_line()
		get_viewport().set_input_as_handled() # Prevent space from triggering other things

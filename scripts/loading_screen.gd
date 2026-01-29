extends Control

const TARGET_SCENE_PATH = "res://scenes/worlds/world.tscn"

@onready var progress_bar = $ProgressBar
@onready var status_label = $StatusLabel

func _ready():
	# Start loading the target scene in the background
	# resource_path is the scene to load
	ResourceLoader.load_threaded_request(TARGET_SCENE_PATH)

func _process(_delta):
	var progress = []
	var status = ResourceLoader.load_threaded_get_status(TARGET_SCENE_PATH, progress)
	
	if progress_bar:
		progress_bar.value = progress[0] * 100
	
	if status == ResourceLoader.THREAD_LOAD_LOADED:
		var packed_scene = ResourceLoader.load_threaded_get(TARGET_SCENE_PATH)
		get_tree().change_scene_to_packed(packed_scene)
	elif status == ResourceLoader.THREAD_LOAD_FAILED:
		if status_label:
			status_label.text = "Loading Failed!"
		print("Error loading resource")

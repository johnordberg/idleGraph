extends GraphNode

var graph: GraphEdit
var current_connected_node: GraphNode
@export var quest_label: Label
@export var quest_progress: ProgressBar

var current_quest_type: String = "click"
var current_quest_value: String = "press"
var current_quest_goal: int = 100

var current_quest_progress: int

var storage: Array[Dictionary]

func _ready():
	print("Quest Node ready")
	# Defer the connection setup until the next frame to ensure graph is set
	call_deferred("setup_connections")
	quest_progress.max_value = current_quest_goal

func setup_connections():
	if graph != null:
		print("Quest Node: Connecting to graph.connected signal")
		graph.connected.connect(_on_connection_made)
		print("Quest Node: Successfully connected to signal")
	else:
		print("Warning: graph is null in quest_node")

func _process(delta):
	if (quest_progress.value != current_quest_progress):
		quest_progress.value += (current_quest_progress - quest_progress.value) * delta * 10
	if (quest_progress.value - current_quest_progress) < 0.1:
		quest_progress.value = current_quest_progress

func _on_connection_made(from_node: GraphNode, from_port: int, to_node: GraphNode, to_port: int):
	print("Connection made: ", from_node.name)
	if to_node != self:
		return
	current_connected_node = from_node
	current_connected_node.output.connect(_on_recieve_input)
	print("Connection made: ", from_node.name)
	
func _on_recieve_input(type: String, value: String, quantity: int):
	print("Output: ", type, value, quantity)
	var existing_index = -1
	for i in range(storage.size()):
		if storage[i]["value"] == value:
			existing_index = i
			break
	
	if existing_index == -1:
		storage.append({
			"type": type,
			"value": value,
			"quantity": quantity
		})
	else:
		storage[existing_index]["quantity"] += quantity
	
	if current_quest_type == type and current_quest_value == value:
		current_quest_progress += quantity
		quest_progress.value = current_quest_progress
		if current_quest_progress >= current_quest_goal:
			current_quest_progress = 0
			current_quest_goal = 0
			current_quest_type = ""
			current_quest_value = ""

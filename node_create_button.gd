class_name NodeCreateButton
extends Button

@export var node_to_create: PackedScene
var graph: GraphEdit

func _init():
	alignment = HORIZONTAL_ALIGNMENT_LEFT

func _on_pressed():
	var node = node_to_create.instantiate()
	graph.add_child(node)
	node.graph = graph

func _ready():
	graph = %GraphEdit

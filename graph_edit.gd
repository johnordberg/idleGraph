extends GraphEdit

signal connected(from_node, from_port, to_node, to_port)

func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_connection_request(from_node, from_port, to_node, to_port):
	print("GraphEdit: Connection request received - ", from_node, " to ", to_node)
	# Get actual node references from names
	var from_node_ref = get_node(NodePath(from_node))
	var to_node_ref = get_node(NodePath(to_node))
	print("GraphEdit: Node references - ", from_node_ref, " to ", to_node_ref)
	
	connect_node(from_node, from_port, to_node, to_port)
	print("GraphEdit: Emitting connected signal")
	connected.emit(from_node_ref, from_port, to_node_ref, to_port)

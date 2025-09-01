class_name IdleGraphNode
extends GraphNode

var slot_input_map: Dictionary

func _init():
	_setup_input_map()

func _setup_input_map():
	#should find each Graph Row that is a direct child of this node, and map the input types to correlate with the connection on the left side of that slot
	for child in get_children():
		if child is GraphRow:
			slot_input_map[child.slot_index] = child.input_types

func _get_input_types_of_slot(slot_index: int):
	if slot_input_map.has(slot_index):
		return slot_input_map[slot_index]
	return []

func is_input_accepted(slot_index: int, type: String):
	var input_types = _get_input_types_of_slot(slot_index)
	return input_types.has(type)

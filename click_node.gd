extends IdleGraphNode

var graph: GraphEdit

signal output(type, value, quantity)

func _on_button_pressed():
	print("Click Node pressed")
	output.emit("click", "press", 1)

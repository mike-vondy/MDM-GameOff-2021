extends Position2D

func _ready():
	var character_node = $'..'
	character_node.connect("look_changed", self, "_on_Character_look_changed")
	set_process(false)
	
	
func _on_Character_look_changed(mouse):
	look_at(mouse)

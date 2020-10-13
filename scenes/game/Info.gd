extends RichTextLabel

func display_info(entity: Entity):
	clear()
	if entity:
		get_parent().swap()
	else:
		visible = false
		get_node("../Log").visible = true
		return
	append_bbcode(entity.get_name())


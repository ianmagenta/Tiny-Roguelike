extends RichTextLabel

func display_info(entity: Entity):
	if entity:
		get_parent().get_node("Log").visible = false
		visible = true
	else:
		visible = false
		get_parent().get_node("Log").visible = true
		clear()
		return
	append_bbcode(entity.get_name())


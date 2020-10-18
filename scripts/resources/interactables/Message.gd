extends Resource

class_name Message

export(String) var before_first_actor = ""
export(String) var between_actors = ""
export(String) var after_second_actor = ""

func emit(actor1=null, actor2=null):
	var export_string: String = ""
	export_string += before_first_actor
	if actor1:
		export_string += actor1.get_bbcode_name()
	export_string += between_actors
	if actor2:
		export_string += actor2.get_bbcode_name(false)
	export_string += after_second_actor
	Globals.message_log.add_message(export_string)

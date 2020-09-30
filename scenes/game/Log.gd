extends RichTextLabel

var entries = []
var repeat_counter = 1

func add_message(message: String):
	clear()
	if entries and message == entries[0]:
		repeat_counter += 1
		append_bbcode(message + " x" + str(repeat_counter))
	elif repeat_counter > 1:
		entries[0] += " x" + str(repeat_counter)
		repeat_counter = 1
		append_bbcode(message)
	else:
		append_bbcode(message)
	newline()
	for i in entries:
		append_bbcode(i)
		newline()
	if entries and message == entries[0]:
		return
	else:
		entries.push_front(message)

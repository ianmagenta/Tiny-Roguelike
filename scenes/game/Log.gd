extends ScrollContainer
#
#export var text_speed = 0.25
#
#var entries = ['Message log start!', '\n', '\n', '\n', '\n', '\n', '\n']
#var message_queue = []
#var repeat_counter = 1
#var processing_update = false
#
#onready var tween: Tween = $Tween
#
#func _init():
#	Events.connect("message_emitted", self, "add_message")
#
#func add_message(message: String):
#	message_queue.append(message)
#	if !processing_update:
#		processing_update = true
#		var divider = "---------------------"
#		while message_queue:
#			var new_message = message_queue.pop_front()
#			clear()
#			append_bbcode(new_message)
#			var new_message_length = text.length()
#			clear()
#			for i in range(entries.size() - 1):
#				if entries[i] != "\n":
#					append_bbcode(entries[i])
#				newline()
#			if new_message == entries.back():
#				repeat_counter += 1
#				append_bbcode(divider)
#				newline()
#				var appended_text = " x" + str(repeat_counter)
#				append_bbcode(new_message + appended_text)
#				new_message_length += appended_text.length()
#			else:
#				if repeat_counter > 1:
#					entries[-1] = entries[-1] + " x" + str(repeat_counter)
#					repeat_counter = 1
#				append_bbcode(entries[-1])
#				newline()
#				append_bbcode(divider)
#				newline()
#				append_bbcode(new_message)
#				entries.push_back(new_message)
#			var num_characters = text.length() - entries.size() - new_message_length
#			visible_characters = num_characters
#			tween.interpolate_property(self, "visible_characters", num_characters, num_characters + new_message_length, text_speed)
#			tween.start()
#			yield(tween, "tween_completed")
#			yield(get_tree(), "idle_frame")
#		processing_update = false
#
#func clear_log():
#	clear()
#	entries = ['Message log start!', '\n', '\n', '\n', '\n', '\n', '\n']
#	message_queue.clear()
#	repeat_counter = 1

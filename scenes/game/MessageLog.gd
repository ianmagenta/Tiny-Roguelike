extends ScrollContainer

export var message_print_speed = 0.25

var counter = 1
var raw_new_text: String = ""
var message_queue = []
var processing_messge = false

onready var old_text: RichTextLabel = $VBoxContainer/OldText
onready var new_text: RichTextLabel = $VBoxContainer/NewText
onready var new_text_tween: Tween = $VBoxContainer/NewText/Tween
onready var v_scrollbar: VScrollBar = get_v_scrollbar()
onready var tree = get_tree()

func _ready():
	Events.connect("message_emitted", self, "_add_message")

func _add_message(new_message):
	message_queue.append(new_message)
	if !processing_messge:
		processing_messge = true
		while message_queue:
			var message = message_queue.pop_front()
			if message == raw_new_text:
				counter += 1
				new_text.clear()
				new_text.append_bbcode(str(raw_new_text, " x", counter))
			else:
				old_text.newline()
				if counter > 1:
					old_text.append_bbcode(str(raw_new_text, " x", counter))
					counter = 1
				else:
					old_text.append_bbcode(raw_new_text)
				new_text.clear()
				new_text.append_bbcode(message)
			new_text_tween.interpolate_property(new_text, "percent_visible", 0.0, 1.0, message_print_speed)
			new_text_tween.interpolate_property(self, "scroll_vertical", scroll_vertical, rect_size.y, 0.0)
			new_text_tween.start()
			yield(new_text_tween, "tween_all_completed")
			raw_new_text = message
			yield(tree, "idle_frame")
			yield(tree, "idle_frame")
		processing_messge = false

extends Control

onready var chatLog = get_node("VBoxContainer/RichTextLabel")
onready var inputField = get_node("VBoxContainer/HBoxContainer/LineEdit")
export var levelname="Level2"
func _ready():
	inputField.connect("text_entered", self,'text_entered')

func add_message(username, text):
	chatLog.bbcode_text += '[color=' + '#101010' + ']'
	chatLog.bbcode_text += '[' + username + ']: '
	chatLog.bbcode_text += text
	chatLog.bbcode_text += '[/color]'
	chatLog.bbcode_text += '\n' 

func text_entered(text):
	if text != '':
		print(text)
		add_message("Player", text)
		inputField.text = ''

	if text != 'correct':
		print("System", "Access Denied, Incorrect Keyword")
		add_message("System", "Access Denied, Incorrect Keyword")
	
	else:
		print("System", "Access Granted, Correct Keyword")
		add_message("System", "Access Granted, Correct Keyword")
		yield(get_tree().create_timer(0.5), "timeout")

extends Control

onready var chatLog = get_node("VBoxContainer/RichTextLabel")
onready var inputLabel = get_node("VBoxContainer/HBoxContainer/Label")
onready var inputField = get_node("VBoxContainer/HBoxContainer/LineEdit")

var user_name = 'Player'

func _ready():
	inputField.connect("text_entered", self,'text_entered')

func add_message(username, text, group = 0, color = ''):
	chatLog.bbcode_text += '\n' 

	if username != '':
		chatLog.bbcode_text += '[' + username + ']: '
	chatLog.bbcode_text += text


func text_entered(text):
	var input = text
	if text != '':
		add_message(user_name, text)
		print(input)
		inputField.text = ''

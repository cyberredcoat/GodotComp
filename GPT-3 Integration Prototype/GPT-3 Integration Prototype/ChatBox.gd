extends Control

var user_name = 'Player'
var GPT3 = 'GPT-3'

onready var chatLog = get_node("VBoxContainer/RichTextLabel")
onready var inputLabel = get_node("VBoxContainer/HBoxContainer/Label")
onready var inputField = get_node("VBoxContainer/HBoxContainer/LineEdit")

#GPT3
var api_key = "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"
var user_input
var api_response_data
#GPT3 End

func _ready():
	inputField.connect("text_entered", self,'text_entered')
	inputField.connect("text_changed", self, "_on_input_changed") #GPT3

func add_message(username, text, group = 0, color = ''):
	chatLog.bbcode_text += '\n' 

	if username != '':
		chatLog.bbcode_text += '[' + username + ']: '
	chatLog.bbcode_text += text

func text_entered(text):
	var input = text
	var endpoint = "https://api.openai.com/endpoint?input=" + input + "&api_key=" + api_key
	var headers = { "Authorization": "Bearer " + api_key }
	var request = HTTPRequest.new()
	add_child(request)
	if text != '':
		add_message(user_name, text)
		print(input)
		inputField.text = ''
		request.request_type = HTTPRequest.REQUEST_GET
		request.url = endpoint
		request.headers = headers
		request.connect("request_completed", self, "_http_request_completed")
		request.send()

func _on_request_completed(request):

	var response_data = request.get_response_body_as_string()
	self.api_response_data = response_data
	request.request_type = HTTPRequest.REQUEST_GET
	print(response_data)
	add_message(GPT3, response_data)

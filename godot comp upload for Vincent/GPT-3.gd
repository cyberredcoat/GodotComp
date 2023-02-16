extends Control

onready var chatLog = get_node("VBoxContainer/RichTextLabel")
onready var inputField = get_node("LineEdit")

var user_name = 'Player'

func deletechild(_a, _b, _c, _d, child):
	child.queue_free()

func fetch(url:String, headers:Array = [],method =  HTTPClient.METHOD_POST, callback:String = "", body = null):
	if url == null or url == "":
		return null
	var http_request = HTTPRequest.new()
	
	add_child(http_request)
	http_request.connect("request_completed", self, callback)
	http_request.connect("request_completed", self, "deletechild", [http_request])
	
	var request
	request = http_request.request(url, headers,true, method, body)
	if request != OK:
		return "error"

func _ready():
	inputField.connect("text_entered", self,'text_entered')

func add_message(username, text):
	chatLog.bbcode_text += '\n' 
	chatLog.bbcode_text += '[color=' + '#101010' + ']'
	chatLog.bbcode_text += '[' + username + ']: '
	chatLog.bbcode_text += text
	chatLog.bbcode_text += '[/color]'
	chatLog.bbcode_text += '\n' 

func text_entered(text):
	if text != '':
		add_message(user_name, text)
		print(text)
		inputField.text = ''
		var json = to_json({"model":"text-davinci-003","prompt":text,"max_tokens":50,"temperature":0.5})
		fetch("https://api.openai.com/v1/completions", ["Authorization:Bearer <API KEY HERE>","Content-Type: application/json"], 2, "handle_response",json)
		print("Waiting for response...")
		add_message("System", "Waiting for response...")

func handle_response(result, response_code, headers, body):
	var response = parse_json(body.get_string_from_utf8())
	print("GPT-3", response)
	add_message("GPT-3", response.choices[0].text)

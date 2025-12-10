extends Node2D

@onready var MyCSharpScript = Arduino_Master_Script

@onready var text1 = $RichTextLabel
@onready var text2 = $RichTextLabel2

var temp = []
var str


func _ready() -> void:
	pass

func _process(delta: float) -> void:
	#temp = string_to_bool_grid(MyCSharpScript.Powered_String)
	
	text1.text = str(MyCSharpScript.getPower(0,0))
	text2.text = MyCSharpScript.text2;
	
func string_to_bool_grid(data: String) -> Array:
	if data.length() != 48:
		push_error("Input must be exactly 48 characters.")
		return []

	var result := []
	var index := 0

	for row in range(8):
		var row_array := []
		for col in range(6):
			var ch := data[index]
			row_array.append(ch == "T")
			index += 1
			result.append(row_array)
	return result

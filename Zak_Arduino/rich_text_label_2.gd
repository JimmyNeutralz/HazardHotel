extends RichTextLabel

@onready var MyCSharpScript = Arduino_Master_Script

var test = [0, 0, 0, 0, 0];

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	self.text = MyCSharpScript.serialMessage
	
func _physics_process(_delta: float) -> void:
	print("|" + MyCSharpScript.serialMessage + "|")

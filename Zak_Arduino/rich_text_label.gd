extends RichTextLabel

@onready var MyCSharpScript = Arduino_Master_Script

var test = [0, 0, 0, 0, 0];

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	pass
	
func _physics_process(_delta: float) -> void:
	print("|" + MyCSharpScript.serialMessage + "|")
	pass

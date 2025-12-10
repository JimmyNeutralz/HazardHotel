extends Node2D

@onready var MyCSharpScript = Arduino_Master_Script

@onready var text1 = $RichTextLabel
@onready var text2 = $RichTextLabel2


func _ready() -> void:
	pass

func _process(delta: float) -> void:
	text1.text = MyCSharpScript.text1;
	text2.text = MyCSharpScript.text2;
	
func _physics_process(_delta: float) -> void:
	print("|" + MyCSharpScript.serialMessage + "|")
	pass

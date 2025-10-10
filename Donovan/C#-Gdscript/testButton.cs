using Godot;
using static Godot.GD;
using System;



public partial class testButton : Node
{
	public string IsPressed { get; set; } = "Not Pressed!";
	
	//[Signal] public delegate void MySignalEventHandler();
	//[Signal] public delegate void MySignalWithParamsEventHandler(string msg, int n);
	
	
	public override void _Input(InputEvent @event){
		if (@event.IsActionPressed("right")){
			IsPressed = "Pressed!";
		}
		
		if (@event.IsActionPressed("left")){
			IsPressed = "Not Pressed!";
		}
	}
}

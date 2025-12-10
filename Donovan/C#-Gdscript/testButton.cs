using Godot;
using static Godot.GD;
using System;



public partial class testButton : Node
{
	public string IsPressed { get; set; } = "Not Pressed!";
	
	
	public override void _Input(InputEvent @event){
		if (@event.IsActionPressed("right")){
			IsPressed = "Pressed!";
		}
		
		if (@event.IsActionPressed("left")){
			IsPressed = "Not Pressed!";
		}
	}
}

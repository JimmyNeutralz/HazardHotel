using Godot;
using System;
using static Godot.GD;

[GlobalClass]
public partial class bigtest : Node2D
{
	
	//[Export] public Node plink = new;
	
	
	
	public override void _PhysicsProcess(double delta){
		//GD.Print(plink.Get("isPressed"));
	}
	
	
}

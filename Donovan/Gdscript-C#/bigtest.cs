using Godot;
using System;
using static Godot.GD;

[GlobalClass]
public partial class Bigtest : Node2D
{
	
	//[Export] public Node plink = new;
	
	
	
	public override void _PhysicsProcess(double delta){
		//GD.Print(plink.Get("isPressed"));
	}
	
	
}

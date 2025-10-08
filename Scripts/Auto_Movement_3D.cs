using Godot;
using System;



public partial class Auto_Movement_3D : Node
{
	private int speed = 2;
	private CollisionShape3D hitBox;
	private CharacterBody3D player;
	
	public Vector3 direction = new Vector3(0, 0, 0);
	public float stopPoint = 2.66f;

	public bool leftKeyPressed = false;
	public bool rightKeyPressed = false;
	public bool centerKeyPressed = false;

	public override void _Ready() {
		hitBox = CollisionShape3D;
		player = load("res://Scenes/3d_player.tscn");
	}

	public void _Process(){
		if (Input.IsKeyPressed(Key.A) && !leftKeyPressed) {
			leftKeyPressed = true;
			rightKeyPressed = false;
			centerKeyPressed = false;
			direction = new Vector3(-stopPoint,0,0);
		}
		else if (Input.IsKeyPressed(Key.D) && !rightKeyPressed) {
			leftKeyPressed = false;
			rightKeyPressed = true;
			centerKeyPressed = false;
			direction = new Vector3(stopPoint,0,0);
		}
		else if (Input.IsKeyPressed(Key.S) && centerKeyPressed) {
			leftKeyPressed = false;
			rightKeyPressed = false;
			centerKeyPressed = true;
			if (player.GlobalPosition.x >= 0) {
				direction = new Vector3(-stopPoint, 0, 0);
			}
			else if (player.global_position.x <= 0) {
				direction = new Vector3(stopPoint, 0, 0);
			}
		}

		if (leftKeyPressed || rightKeyPressed || centerKeyPressed) {
			player.global_position += direction * delta * speed;
			
			// player.GlobalTransform
		}
	}
}

using Godot;
using System;
using System.IO.Ports;
using System.Collections.Generic;

public partial class ArduinOhNo : Node
{
	SerialPort serialPort;
	RichTextLabel text;
	RichTextLabel text2;
	string serialMessage;
	
	bool heard = false;
	
	public override void _Ready() {
		text = GetNode<RichTextLabel>("RichTextLabel");
		text2 = GetNode<RichTextLabel>("RichTextLabel2");
		
		serialPort = new SerialPort();
		serialPort.PortName = "COM4";
		serialPort.BaudRate = 9600;
		serialPort.Open();
		
	}
	
	public override void _Process(double delta) {
		if(!serialPort.IsOpen) {return;}
		
		serialMessage = serialPort.ReadLine();
		//serialMessage = serialPort.ReadExisting();
		
		if(serialMessage == "true") {
			heard = true;
		}
		
		if(heard) {
			text.Text = "Godot, what plug is being used?";
			//serialPort.Write("1");
			if(serialMessage == "") {
				text2.Text = "...";
			}
			if(serialMessage == "r") {
				text2.Text = "1";
			}
			if(serialMessage == "g") {
				text2.Text = "2";
			}
			if(serialMessage == "b") {
				text2.Text = "3";
			}
			if(serialMessage == "rg") {
				text2.Text = "4";
			}
			if(serialMessage == "gb") {
				text2.Text = "5";
			}
			if(serialMessage == "rb") {
				text2.Text = "6";
			}
			if(serialMessage == "rgb") {
				text2.Text = "7";
			}
		}
	}

}

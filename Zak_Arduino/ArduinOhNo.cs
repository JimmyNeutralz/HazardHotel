using Godot;
using System;
using System.IO.Ports;
using System.Collections.Generic;

public partial class ArduinOhNo : Node2D {
	SerialPort serialPort;
	string serialMessage;
	string text1;
	string text2;
	string Powered_String;
	
	int[,] btns = new int[16, 12];
	int[,] plugs = new int[8, 6];
	bool[,] Powered_Array = new bool[8, 6];
	
	public override void _Ready() {
		
		serialPort = new SerialPort();
		serialPort.PortName = "COM3";
		serialPort.BaudRate = 9600;
		serialPort.Open();
	}
	
	public override void _Process(double delta) {
		if(!serialPort.IsOpen) {return;}
		
		serialMessage = serialPort.ReadLine();
		
		btns = readSerial(serialMessage);
		plugs = Compress2x2(btns);
		Powered_Array = GetPoweredSlots(plugs);
		
		text2 = "";
		Powered_String = "";
		for(int i = 0; i < 8; i++) {
			for(int j = 0; j < 6; j++) {
				if (Powered_Array[i, j]) {
					text2 += 'T';	
					Powered_String += 'T';
				}
				else {
					text2 += 'F'; 
					Powered_String += 'F'; 
				}
			}
			text2 += "\n";
		}
	}
	
	public bool getPower(int row, int col) {
		return(Powered_Array[row, col]);
	}
	
	public int[,] readSerial(string message) {
		int index = 0;
		for (int i = 0; i < 16; i++) {
			for (int j = 0; j < 12; j++) {
				btns[i, j] = serialMessage[index] - '0';
				index++;
			}
		}
		return btns;
	}
	
	public int[,] Compress2x2(int[,] btns) {
		int[,] result = new int[8, 6]; // 16/2 = 8, 12/2 = 6

		for (int r = 0; r < 8; r++) {
			for (int c = 0; c < 6; c++) {
				int r0 = r * 2;
				int c0 = c * 2;
			// Sum the 2x2 block
				result[r, c] = btns[r0, c0] + btns[r0, c0 + 1]*2 + btns[r0 + 1, c0]*4 + btns[r0 + 1, c0 + 1]*8;
			}
		}

		return result;
	}
	
	public bool[,] GetPoweredSlots(int[,] board) {
	if (board.GetLength(0) != 8 || board.GetLength(1) != 6)
		throw new ArgumentException("Input must be 8x6.");

		bool[,] powered = new bool[8,6];

	// ================================
	//  SECTION MAPPING
	// ================================
	//
	// 0  = top rail
	// 1–6  = column top halves (col 0–5)
	// 7–12 = column bottom halves (col 0–5)
	// 13 = bottom rail
	//
	int[,] section = new int[8,6];

	// Top power rail
	for (int c = 0; c < 6; c++)
		section[0,c] = 0;

	// Bottom power rail
	for (int c = 0; c < 6; c++)
		section[7,c] = 13;

	// Top halves (sections 1–6)
	for (int c = 0; c < 6; c++)
		for (int r = 1; r <= 3; r++)
			section[r,c] = 1 + c;

	// Bottom halves (sections 7–12)
	for (int c = 0; c < 6; c++)
		for (int r = 4; r <= 6; r++)
			section[r,c] = 7 + c;

	int sectionCount = 14;

	// ================================
	//  GATHER DATA PER SECTION
	// ================================
	List<HashSet<int>> wireIDs = new List<HashSet<int>>();
	List<bool> hasPos = new List<bool>();
	List<bool> hasGnd = new List<bool>();

	for (int i = 0; i < sectionCount; i++)
	{
		wireIDs.Add(new HashSet<int>());
		hasPos.Add(false);
		hasGnd.Add(false);
	}

	// Scan for wires
	for (int r = 0; r < 8; r++)
	{
		for (int c = 0; c < 6; c++)
		{
			int s = section[r,c];
			int v = board[r,c];

			if (v == 1) hasPos[s] = true;
			else if (v == 2) hasGnd[s] = true;
			else if (v >= 3 && v <= 15)
				wireIDs[s].Add(v);
		}
	}

	// ================================
	// BUILD SECTION CONNECTION GRAPH
	// ================================
	List<HashSet<int>> graph = new List<HashSet<int>>();
	for (int i = 0; i < sectionCount; i++)
		graph.Add(new HashSet<int>());

	// Connect sections that share any wire ID
	for (int a = 0; a < sectionCount; a++)
	{
		for (int b = a + 1; b < sectionCount; b++)
		{
			if (wireIDs[a].Overlaps(wireIDs[b]))
			{
				graph[a].Add(b);
				graph[b].Add(a);
			}
		}
	}

	// ================================
	// PROPAGATE POSITIVE AND GROUND
	// ================================
	bool changed = true;

	while (changed)
	{
		changed = false;

		for (int a = 0; a < sectionCount; a++)
		{
			foreach (int b in graph[a])
			{
				if (hasPos[b] && !hasPos[a]) { hasPos[a] = true; changed = true; }
				if (hasGnd[b] && !hasGnd[a]) { hasGnd[a] = true; changed = true; }
			}
		}
	}

	// ================================
	// FINAL OUTPUT
	// powered = only if BOTH pos & gnd
	// ================================
	for (int r = 0; r < 8; r++)
		for (int c = 0; c < 6; c++)
		{
			int s = section[r,c];
			powered[r,c] = (hasPos[s] && hasGnd[s]);
		}

	return powered;
	}
}
